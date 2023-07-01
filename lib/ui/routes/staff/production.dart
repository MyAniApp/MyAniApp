import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/staff/staff.graphql.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/grid_cards.dart';
import 'package:myaniapp/ui/common/cards/sheet_card.dart';

@RoutePage()
class StaffProductionPage extends StatelessWidget {
  const StaffProductionPage({
    super.key,
    required this.medias,
  });

  final Query$Staff$Staff$staffMedia medias;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Staff Roles',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: GridCards(
              // primary: false,
              card: (index) {
                var item = medias.edges![index]!;

                return GridCard(
                  imageUrl: item.node!.coverImage!.extraLarge!,
                  index: index,
                  aspectRatio: 1.7 / 3,
                  title: item.node!.title!.userPreferred,
                  underTitle: (index, style) => Text(item.staffRole ?? ''),
                  onLongPress: (index) => showMediaCard(context, item.node!),
                  onTap: (index) =>
                      context.router.push(MediaRoute(id: item.node!.id)),
                  chips: (index) {
                    return [
                      GridChip(
                        bottom: 5,
                        right: 5,
                        child: Text(
                          item.node!.type!.name.capitalize(),
                        ),
                      ),
                    ];
                  },
                );
              },
              itemCount: medias.edges!.length,
            ),
          ),
        ),
      ],
    );
  }
}
