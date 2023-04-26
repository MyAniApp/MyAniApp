import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/grid_cards.dart';
import 'package:myaniapp/ui/common/cards/media_cards.dart';
import 'package:myaniapp/ui/common/media_editor/media_editor.dart';

import '../../graphql/__generated/ui/common/media_editor/media_editor.graphql.dart';

class MediaListGroups {
  const MediaListGroups({
    required this.groups,
    this.isEditable = false,
    this.onSave,
  });

  final List<Fragment$ListGroup> groups;
  final bool isEditable;
  final VoidCallback? onSave;

  PreferredSizeWidget get tabBar {
    return TabBar(
      isScrollable: true,
      tabs: [
        for (var group in groups)
          Tab(
            text: '${group.name} (${group.entries?.length ?? 0})',
          )
      ],
    );
  }

  Widget get tabView {
    return TabBarView(
      children: [
        for (var group in groups)
          ListGroup(
            group: group,
            isEditable: isEditable,
            onSave: onSave,
          ),
      ],
    );
  }
}

class ListGroup extends HookWidget {
  const ListGroup({
    super.key,
    required this.group,
    this.isEditable = false,
    this.onSave,
    this.primary,
  });

  final Fragment$ListGroup group;
  final bool isEditable;
  final VoidCallback? onSave;
  final bool? primary;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: true);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MediaCards(
        primary: primary,
        list: group.entries!,
        onTap: (index) {
          var item = group.entries![index];

          context.router.push(MediaRoute(id: item!.media!.id));
        },
        chips: (index) {
          if (!isEditable) return [];
          var item = group.entries![index];

          if ((item!.media!.episodes ?? item.media!.chapters) != null &&
              item.progress! >=
                  (item.media!.episodes ?? item.media!.chapters!)) {
            return [];
          }

          return [
            Mutation$SaveMediaListEntry$Widget(
              options: WidgetOptions$Mutation$SaveMediaListEntry(
                onCompleted: (p0, p1) => onSave?.call(),
              ),
              builder: (p0, p1) => GridChip(
                bottom: 5,
                right: 5,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 30,
                      child: IconButton(
                        onPressed: () => p0(
                          variables: Variables$Mutation$SaveMediaListEntry(
                            id: item.id,
                            progress: (item.progress ?? 0) + 1,
                          ),
                        ),
                        icon: const Icon(Icons.plus_one),
                        padding: EdgeInsets.zero,
                        iconSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${item.progress ?? 0}/${item.media!.episodes ?? item.media!.chapters ?? '??'}',
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        onDoubleTap: !isEditable
            ? null
            : (index) {
                var item = group.entries![index];

                showMediaEditor(context, item!.media!, onSave: onSave);
              },
      ),
    );
  }
}
