import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp_v2/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp_v2/providers/settings.dart';
import 'package:myaniapp_v2/ui/common/cards/card_sheet.dart';
import 'package:myaniapp_v2/ui/common/cards/grid_cards.dart';

class MediaCards extends ConsumerWidget {
  const MediaCards({
    super.key,
    required this.list,
    this.chips,
    this.onDoubleTap,
    this.onTap,
    this.underTitle,
    this.primary,
  }) : assert(list is List<Fragment$Media> ||
            list is List<Fragment$Media?> ||
            list is List<Fragment$MediaListEntry> ||
            list is List<Fragment$MediaListEntry?>);

  final Widget Function(int index)? underTitle;
  final List<Widget> Function(int index)? chips;
  final void Function(int index)? onDoubleTap;
  final void Function(int index)? onTap;
  final List list;
  final bool? primary;

  @override
  Widget build(BuildContext context, ref) {
    var settings = ref.watch(settingsProvider);

    return GridCards(
      primary: primary,
      itemCount: list.length,
      card: (index) {
        var entry = list[index];
        var media = entry is Fragment$Media
            ? entry
            : entry is Fragment$MediaListEntry
                ? entry.media
                : null;
        if (media == null) {
          return const SizedBox();
        }

        return GridCard(
          imageUrl: media.coverImage!.large!,
          title: media.title!.userPreferred,
          index: index,
          chips: chips,
          onDoubleTap: onDoubleTap,
          onTap: onTap,
          underTitle: underTitle,
          onLongPress: (index) => showCardSheet(context, media),
        );
      },
    );
  }
}
