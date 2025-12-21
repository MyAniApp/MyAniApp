import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp/app/home/forum/screen.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/comment.dart';
import 'package:myaniapp/common/markdown/markdown.dart';
import 'package:myaniapp/common/markdown_editor.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/fragments/media.graphql.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/__gen/search_media.graphql.dart';
import 'package:myaniapp/graphql/__gen/thread.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:myaniapp/routes.dart';
import 'package:mygraphql/graphql.dart';

final _singleCategories = allCategories.where(
  (cat) => switch (cat.id) {
    7 => true,
    11 => true,
    12 => true,
    17 => true,
    18 => true,
    _ => false,
  },
);

class CreateThread extends HookConsumerWidget {
  const CreateThread({super.key});

  static void show(BuildContext context) {
    showDialog(context: context, builder: (context) => CreateThread());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pageController = usePageController();
    var titleController = useTextEditingController();
    var selectedCategories = useState(<ForumCategory>[]);
    final selectedMedias = useState(<Fragment$MediaFragment>[]);
    var bodyController = useTextEditingController();
    var focusNode = useFocusNode();
    final mockThread = useState<Query$Thread$thread?>(null);

    final categories = useMemoized(() {
      var isSingleUse = _singleCategories.contains(
        selectedCategories.value.firstOrNull,
      );
      if (isSingleUse) {
        return [selectedCategories.value.first];
      } else if (selectedCategories.value.isNotEmpty) {
        return allCategories.whereNot((cat) => _singleCategories.contains(cat));
      }
      return allCategories;
    }, [selectedCategories.value]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Creating a Thread'),
        leading: _BackButton(pageController),
        actions: [
          _PageButton(
            pageController,
            onSend: () {},
            onPreviewPress: () {
              mockThread.value = Query$Thread$thread(
                createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                id: 0,
                likeCount: 0,
                userId: 1,
                user: ref.read(userProvider).value?.parsedData?.Viewer,
                categories: selectedCategories.value
                    .map(
                      (c) => Query$Thread$thread$categories(
                        id: c.id,
                        name: c.name,
                        $__typename: 'jhnkj',
                      ),
                    )
                    .toList(),
                mediaCategories: selectedMedias.value,
                title: titleController.text,
                body: bodyController.text,
              );
            },
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: context.theme.textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    for (var category in categories)
                      FilterChip(
                        selected: selectedCategories.value.contains(category),
                        label: Text(category.name),
                        onSelected: (value) {
                          if (value) {
                            selectedCategories.value = [
                              ...selectedCategories.value..add(category),
                            ];
                          } else {
                            selectedCategories.value = [
                              ...selectedCategories.value..remove(category),
                            ];
                          }
                        },
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: QuickMediaSearch(
                  onSelected: (media) {
                    if (!selectedMedias.value.contains(media)) {
                      selectedMedias.value = [
                        ...selectedMedias.value..add(media),
                      ];
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    for (var media in selectedMedias.value)
                      InputChip(
                        label: Text(media.title!.userPreferred!),
                        onDeleted: () => selectedMedias.value = [
                          ...selectedMedias.value..remove(media),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                color: context.theme.colorScheme.surfaceContainerHigh,
                child: MarkdownToolbar(
                  controller: bodyController,
                  focusNode: focusNode,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.sizeOf(context).shortestSide,
                ),
                child: TextArea(
                  focusNode: focusNode,
                  editingController: bodyController,
                  hint: 'Write body...',
                ),
              ),
            ],
          ),
          _ThreadPreview(mockThread: mockThread.value),
        ],
      ),
    );
  }
}

class _ThreadPreview extends StatelessWidget {
  const _ThreadPreview({super.key, required this.mockThread});

  final Query$Thread$thread? mockThread;

  @override
  Widget build(BuildContext context) {
    if (mockThread == null) return SizedBox();
    print(mockThread?.categories);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            mockThread!.title!,
            style: context.theme.textTheme.headlineMedium,
          ),
        ),
        Comment(
          avatar:
              mockThread?.user?.avatar?.large ??
              'https://s4.anilist.co/file/anilistcdn/user/avatar/large/default.png',
          body: MarkdownWidget.body(data: mockThread!.body!),
          collapsible: false,
          createdAt:
              mockThread?.createdAt ?? DateTime.now().millisecondsSinceEpoch,
          username: mockThread?.user?.name ?? 'Test',
          footer: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var cat in mockThread!.categories!)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ActionChip(
                            label: Text(cat!.name),
                            onPressed: () {},
                          ),
                        ),
                      for (var cat in mockThread!.mediaCategories!)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ActionChip(
                            label: Text(cat!.title!.userPreferred!),
                            onPressed: () => context.push(
                              Routes.media(cat.id),
                              extra: {"placeholder": cat},
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class QuickMediaSearch extends HookWidget {
  const QuickMediaSearch({super.key, required this.onSelected});

  final void Function(Fragment$MediaFragment media) onSelected;

  @override
  Widget build(BuildContext context) {
    final showMedia = useState(false);
    final searchController = useSearchController();
    var fetchMedia = useCallback((String search) async {
      var s = gqlClient.query(
        GQLRequest(
          searchQuery,
          variables: Variables$Query$Search(
            search: search,
            sort: [Enum$MediaSort.SEARCH_MATCH],
          ).toJson(),
          parseData: (data) => Query$Search.fromJson(data),
        ),
      );
      return await s.first;
    });

    return SearchAnchor.bar(
      searchController: searchController,
      barHintText: 'Search for media...',
      onSubmitted: (value) {
        searchController.text = '';
        showMedia.value = true;
        searchController.text = value;
      },
      suggestionsBuilder: (context, controller) async {
        if (showMedia.value && controller.text.isNotEmpty) {
          var res = await fetchMedia(controller.text);
          showMedia.value = false;
          if (res.parsedData != null) {
            return [
              for (var media in res.parsedData!.Page!.media!)
                ListTile(
                  onTap: () {
                    onSelected(media);
                    searchController.closeView(null);
                  },
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90,
                        child: ClipRRect(
                          borderRadius: imageRadius,
                          child: AspectRatio(
                            aspectRatio: 2 / 3,
                            child: CachedImage(
                              media!.coverImage!.extraLarge!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              media.title!.userPreferred!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(media.type!.name.capitalize()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ];
          }
        }
        return [];
        // if (showMedia.value) {
        // timer.value?.operation.cancel();
        // timer.value.complete(Future.delayed(Duration(seconds: 2), () async {
        //   return await fetchMedia(controller.text);
        //   // showMedia.value = false;
        //   // if (res.parsedData != null) {
        //   //   return [
        //   //     for (var media in res.parsedData!.Page!.media!)
        //   //       ListTile(title: Text(media!.title!.userPreferred!))
        //   //   ];
        //   // }
        // }));
        // return [];
        // return timer.value.operation.then();
        // Future.delayed(Duration(seconds: 2), () async {
        //   var res = await fetchMedia(controller.text);
        //   showMedia.value = false;
        //   if (res.parsedData != null) {
        //     return [
        //       for (var media in res.parsedData!.Page!.media!)
        //         ListTile(title: Text(media!.title!.userPreferred!))
        //     ];
        //   }
        // }).ignore();
        // // }

        // return [];
      },
    );
  }
}

class _BackButton extends HookWidget {
  const _BackButton(this.pageController, {super.key});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final page = useListenableSelector(
      pageController,
      () => pageController.page,
    );

    if (page == 0 || page == null) {
      return IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () => context.pop(),
      );
    }

    return BackButton(
      onPressed: () => pageController.animateToPage(
        0,
        duration: Durations.medium2,
        curve: Curves.easeOut,
      ),
    );
  }
}

class _PageButton extends HookWidget {
  const _PageButton(
    this.pageController, {
    super.key,
    required this.onPreviewPress,
    required this.onSend,
  });

  final PageController pageController;
  final VoidCallback onPreviewPress;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final page = useListenableSelector(
      pageController,
      () => pageController.page,
    );

    if (page == 0 || page == null) {
      return TextButton(
        onPressed: () {
          pageController.animateToPage(
            2,
            duration: Durations.medium2,
            curve: Curves.easeIn,
          );
          onPreviewPress();
        },
        child: Text('Preview'),
      );
    }
    return IconButton(icon: Icon(Icons.send), onPressed: () {});
  }
}
