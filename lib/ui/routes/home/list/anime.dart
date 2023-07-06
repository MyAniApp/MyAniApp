import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/common/media_editor/media_editor.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/list/list.graphql.dart';
import 'package:myaniapp/providers/settings.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/grid_cards.dart';
import 'package:myaniapp/ui/common/cards/media_cards.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/media_editor/media_editor.dart';
import 'package:myaniapp/ui/common/numer_picker.dart';
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
                        setting: Setting.animeList,
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
    required this.setting,
  });

  final Fragment$ListGroup list;
  final void Function() refresh;
  final bool canEdit;
  final Setting setting;

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MediaCards(
      list: widget.list.entries!.map((e) => e!.media!).toList(),
      aspectRatio: 1.9 / 3,
      setting: widget.setting,
      onTap: (media, index) => context.pushRoute(MediaRoute(id: media.id)),
      onDoubleTap: widget.canEdit
          ? (media, index) => showMediaEditor(
                context,
                media as Fragment$MediaFragment,
                onDelete: widget.refresh,
                onSave: widget.refresh,
              )
          : null,
      chips: (_, index) {
        if (!widget.canEdit) return [];
        var entry = widget.list.entries![index]!;
        if (entry.status != Enum$MediaListStatus.CURRENT) return [];

        if ((entry.media!.episodes ?? entry.media!.chapters) != null &&
            entry.progress! >=
                (entry.media!.episodes ?? entry.media!.chapters!)) {
          return [];
        }

        return [
          GridChip(
            maxWidth: 100,
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
      underTitle: (media, style, index) {
        if (style != ListStyle.detailedList) return null;
        var entry = widget.list.entries![index]!;

        return Column(
          children: [
            if ((media.episodes ?? media.chapters ?? 0) > 0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: LinearProgressIndicator(
                  value: (entry.progress ?? 0) /
                      (media.episodes ?? media.chapters)!,
                ),
              ),
            // const Spacer(),
            if (widget.canEdit)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: NumberPicker(
                  hint: 'Episode count',
                  number: entry.progress,
                  onIncrement: () => client.value.mutate$SaveMediaListEntry(
                    Options$Mutation$SaveMediaListEntry(
                      variables: Variables$Mutation$SaveMediaListEntry(
                          id: entry.id, progress: (entry.progress ?? 0) + 1),
                    ),
                  ),
                  onDecrement: () => client.value.mutate$SaveMediaListEntry(
                    Options$Mutation$SaveMediaListEntry(
                      variables: Variables$Mutation$SaveMediaListEntry(
                          id: entry.id, progress: (entry.progress ?? 0) - 1),
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
