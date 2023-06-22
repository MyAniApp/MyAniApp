import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/providers/media.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/grid_cards.dart';
import 'package:myaniapp/ui/common/cards/sheet_card.dart';

@RoutePage()
class MediaRelationsPage extends ConsumerWidget {
  const MediaRelationsPage(
      {super.key, @PathParam.inherit('id') required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var media = ref.watch(mediaProvider(id));

    var sorted = media.value!.relations!.edges!
      ..sort(
        (a, b) => a!.relationType!.index.compareTo(b!.relationType!.index),
      );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridCards(
        // childAspectRatio: 1.7 / 3,
        card: (index) {
          var item = sorted[index]!;

          return GridCard(
            aspectRatio: 1.8 / 3,
            imageUrl: item.node!.coverImage!.extraLarge!,
            index: index,
            onTap: (_) => context.pushRoute(MediaRoute(id: item.node!.id)),
            onLongPress: (_) => showMediaCard(context, item.node!),
            title: item.node!.title!.userPreferred,
            underTitle: (_, __) => Text(item.relationType!.name.capitalize()),
          );
        },
        itemCount: sorted.length,
      ),
    );
  }
}
