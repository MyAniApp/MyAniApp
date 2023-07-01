import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/common/media_editor/media_editor.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/list/list.graphql.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/grid_cards.dart';
import 'package:myaniapp/ui/common/cards/sheet_card.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/media_editor/media_editor.dart';
import 'package:myaniapp/ui/routes/home/app_bar.dart';

@RoutePage()
class HomeAnimePage extends ConsumerWidget {
  const HomeAnimePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    return Query$MediaList$Widget(
      options: Options$Query$MediaList(
        cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
        variables: Variables$Query$MediaList(
          sort: [
            Enum$MediaListSort.STATUS,
            Enum$MediaListSort.UPDATED_TIME_DESC,
          ],
          type: Enum$MediaType.ANIME,
          userName: user.value!.name,
        ),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading && result.data == null) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (result.hasException) {
          return GraphqlError(exception: result.exception!);
        }

        var lists = result.parsedData!.MediaListCollection!.lists!;

        if (lists.isEmpty) {
          return RefreshIndicator.adaptive(
            onRefresh: refetch!,
            child: Scaffold(
              appBar: const HomeAppBar(),
              body: LayoutBuilder(
                builder: (context, constraints) => ListView(
                  children: [
                    Container(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => context.pushRoute(
                              SearchRoute(type: Enum$MediaType.ANIME.name)),
                          child: const Text('Browse animes to add'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return RefreshIndicator.adaptive(
          onRefresh: refetch!,
          notificationPredicate: (notification) => notification.depth == 1,
          child: DefaultTabController(
            length: lists.length,
            child: Scaffold(
              appBar: HomeAppBar(
                bottom: TabBar(
                  isScrollable: true,
                  tabs: lists
                      .map(
                        (e) => Tab(
                          text: '${e!.name} (${e.entries!.length})',
                        ),
                      )
                      .toList(),
                ),
              ),
              body: TabBarView(
                children: lists
                    .map(
                      (list) => Media(
                        list: list!,
                        refresh: refetch,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Media extends StatefulWidget {
  const Media({
    super.key,
    required this.list,
    required this.refresh,
    this.canEdit = true,
  });

  final Fragment$ListGroup list;
  final void Function() refresh;
  final bool canEdit;

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridCards(
      // primary: false,
      padding: const EdgeInsets.all(8),
      card: (index) {
        var entry = widget.list.entries![index]!;

        return GridCard(
          imageUrl: entry.media!.coverImage!.extraLarge!,
          title: entry.media!.title!.userPreferred,
          aspectRatio: 1.9 / 3,
          index: index,
          onTap: (index) => context.pushRoute(MediaRoute(id: entry.mediaId)),
          onLongPress: (index) => showMediaCard(context, entry.media!),
          onDoubleTap: widget.canEdit
              ? (index) => showMediaEditor(
                    context,
                    entry.media!,
                    onDelete: widget.refresh,
                    onSave: widget.refresh,
                  )
              : null,
          chips: (index) {
            if (entry.status != Enum$MediaListStatus.CURRENT) return [];

            if ((entry.media!.episodes ?? entry.media!.chapters) != null &&
                entry.progress! >=
                    (entry.media!.episodes ?? entry.media!.chapters!)) {
              return [];
            }

            return [
              GridChip(
                bottom: 5,
                right: 5,
                child: Row(
                  children: [
                    SizedBox(
                      height: 25,
                      width: 30,
                      child: IconButton(
                        onPressed: () => client.value.mutate$SaveMediaListEntry(
                          Options$Mutation$SaveMediaListEntry(
                            variables: Variables$Mutation$SaveMediaListEntry(
                              id: entry.id,
                              progress: (entry.progress ?? 0) + 1,
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.add),
                        padding: EdgeInsets.zero,
                        iconSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${entry.progress ?? '0'} / ${entry.media!.episodes ?? entry.media!.chapters ?? '??'}',
                    )
                  ],
                ),
              ),
            ];
          },
        );
      },
      itemCount: widget.list.entries!.length,
    );
  }
}
