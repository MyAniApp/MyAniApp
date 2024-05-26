import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:collection/collection.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/common/lists/__generated__/lists.data.gql.dart';
import 'package:myaniapp/common/lists/__generated__/lists.req.gql.dart';
import 'package:myaniapp/common/media_cards/grid_card.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/media_editor/media_editor.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__generated__/schema.schema.gql.dart';
import 'package:myaniapp/graphql/fragments/__generated__/list_group.data.gql.dart';
import 'package:myaniapp/graphql/widget.dart';

class UserAnimePage extends StatelessWidget {
  const UserAnimePage({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return GQLRequest(
      loading: Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      error: (response) => Scaffold(
        appBar: AppBar(),
        body: GraphqlError(
          exception: (response?.graphqlErrors, response?.linkException),
          req: response?.operationRequest,
        ),
      ),
      operationRequest: GMediaListReq(
        (b) => b
          ..requestId = "mediaList$name"
          ..vars.userName = name
          ..vars.type = GMediaType.ANIME
          ..fetchPolicy = FetchPolicy.NoCache,
      ),
      builder: (context, response, error, refetch) {
        return RefreshIndicator.adaptive(
          onRefresh: refetch,
          notificationPredicate: (notification) => notification.depth == 1,
          child: MediaListView(
            onDelete: refetch,
            groups: response!.data!.MediaListCollection!.lists!
                .whereType<GListGroup>()
                .toBuiltList(),
            user: response.data!.MediaListCollection!.user!,
            type: GMediaType.ANIME,
          ),
        );
      },
    );
  }
}

class MediaListView extends StatefulWidget {
  const MediaListView({
    super.key,
    required this.groups,
    required this.user,
    required this.type,
    this.appBarLeading,
    this.onDelete,
  });

  final BuiltList<GListGroup> groups;
  final GMediaListData_MediaListCollection_user user;
  final GMediaType type;
  final Widget? appBarLeading;
  final VoidCallback? onDelete;

  @override
  State<MediaListView> createState() => _MediaListViewState();
}

class _MediaListViewState extends State<MediaListView>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<GListGroup> groups = [];
  late GMediaListSort sort;

  @override
  void didUpdateWidget(covariant MediaListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.groups.toString() != widget.groups.toString()) {
      setGroups(widget.groups);
    }
  }

  @override
  void initState() {
    super.initState();
    setGroups(widget.groups);
  }

  void setGroups(BuiltList<GListGroup> listGroups) {
    if (groups.isNotEmpty) groups.clear();
    for (var section
        in widget.user.mediaListOptions!.animeList!.sectionOrder!) {
      var entry =
          listGroups.firstWhereOrNull((element) => element.name! == section);

      if (entry != null) groups.add(entry);
    }
    if (listGroups.length != groups.length) {
      var leftover = listGroups.where((p0) => !widget
          .user.mediaListOptions!.animeList!.sectionOrder!
          .contains(p0.name));
      groups.addAll(leftover);
    }
    if (_tabController?.length != groups.length) {
      _tabController = TabController(length: groups.length, vsync: this);
    }
    sort = switch (widget.user.mediaListOptions!.rowOrder!) {
      'score' => GMediaListSort.SCORE_DESC,
      'title' => GMediaListSort.MEDIA_TITLE_NATIVE_DESC,
      'updatedAt' => GMediaListSort.UPDATED_TIME_DESC,
      'id' => GMediaListSort.ADDED_TIME_DESC,
      _ => GMediaListSort.UPDATED_TIME_DESC,
    };
    sortEntries();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  void sortEntries() {
    for (var (index, group) in groups.indexed) {
      var list = group.entries!.toList();
      switch (sort) {
        case GMediaListSort.SCORE_DESC:
          list.sort(
            (a, b) {
              if (a!.score == b!.score) {
                return a.media!.title!.userPreferred!
                    .toLowerCase()
                    .compareTo(b.media!.title!.userPreferred!.toLowerCase());
              }

              return (b.score ?? 0).compareTo(a.score ?? 0);
            },
          );
          break;
        case GMediaListSort.MEDIA_TITLE_NATIVE_DESC:
          list.sort(
            (a, b) => a!.media!.title!.userPreferred!
                .compareTo(b!.media!.title!.userPreferred!),
          );
          break;
        case GMediaListSort.ADDED_TIME_DESC:
          list.sort(
            (a, b) => a!.id.compareTo(b!.id),
          );
          break;
        default:
          list.sort(
            (a, b) {
              if (a!.updatedAt == b!.updatedAt) {
                return a.media!.title!.userPreferred!
                    .toLowerCase()
                    .compareTo(b.media!.title!.userPreferred!.toLowerCase());
              }

              return b.updatedAt?.compareTo(a.updatedAt ?? 0) ?? 0;
            },
          );
          break;
      }

      group = (group as GMediaListData_MediaListCollection_lists).rebuild(
          (p0) => p0.entries
            ..clear()
            ..addAll(list as Iterable<
                GMediaListData_MediaListCollection_lists_entries?>));

      groups.setAll(index, [group]);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.appBarLeading,
        actions: [
          IconButton(
            onPressed: () {
              var list = groups.expand((element) => element.entries!);
              context.push(
                  '/media/${list.elementAt(Random().nextInt(list.length))!.media!.id}/info');
            },
            icon: const Icon(Icons.shuffle),
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (context) => DraggableScrollableSheet(
                expand: false,
                builder: (context, scrollController) => ListView(
                  controller: scrollController,
                  children: [
                    GMediaListSort.MEDIA_TITLE_NATIVE_DESC,
                    GMediaListSort.ADDED_TIME_DESC,
                    GMediaListSort.SCORE_DESC,
                    GMediaListSort.UPDATED_TIME_DESC,
                  ]
                      .map(
                        (e) => RadioListTile<GMediaListSort>.adaptive(
                          value: e,
                          groupValue: sort,
                          title: Text(e.name.capitalize()),
                          onChanged: (value) {
                            sort = value ?? GMediaListSort.UPDATED_TIME_DESC;
                            sortEntries();
                            context.pop();
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            icon: const Icon(Icons.sort),
          ),
          const SizedBox(
            width: 5,
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            for (var group in groups)
              Tab(text: "${group.name} (${group.entries!.length})")
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (var group in groups)
            GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: GridCard.listRatio,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                var entry = group.entries![index]!;

                return GridCard(
                  image: entry.media!.coverImage!.extraLarge!,
                  title: entry.media!.title!.userPreferred,
                  onLongPress: () => MediaSheet.show(context, entry.media!),
                  onTap: () => context.push("/media/${entry.media!.id}/info",
                      extra: {"media": entry.media}),
                  onDoubleTap: () => MediaEditorDialog.show(
                    context,
                    entry.media!,
                    widget.user.id,
                    onSave: () {},
                    onDelete: () => widget.onDelete?.call(),
                  ),
                  blur: entry.media!.isAdult!,
                  chips: [
                    if ((entry.score ?? 0) != 0)
                      GridChip(
                        top: 5,
                        left: 5,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              (entry.score ?? 0).toString(),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
              itemCount: group.entries!.length,
            )
        ],
      ),
    );
  }
}
