import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/ink_well_image.dart';
import 'package:myaniapp/common/media_cards/grid_card.dart';
import 'package:myaniapp/common/media_cards/list_card.dart';
import 'package:myaniapp/common/media_cards/media_card.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/show.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/__gen/staff.graphql.dart';
import 'package:myaniapp/providers/list_settings.dart';
import 'package:myaniapp/routes.dart';

class StaffVARolesScreen extends ConsumerStatefulWidget {
  const StaffVARolesScreen({
    super.key,
    required this.medias,
    required this.sort,
  });

  final Query$Staff$Staff$characterMedia medias;
  final Enum$MediaSort sort;

  @override
  ConsumerState<StaffVARolesScreen> createState() => _StaffVARolesScreenState();
}

class _StaffVARolesScreenState extends ConsumerState<StaffVARolesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var listSetting = ref.watch(
      listSettingsProvider.select((value) => value.staffVA),
    );

    switch (widget.sort) {
      case .START_DATE:
      case .START_DATE_DESC:
        var years = _Media.sort(
          widget.medias.edges!,
          widget.sort == .START_DATE_DESC,
        );

        return ListView.builder(
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            var year = years[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    year.year == 0 ? "TBA" : year.year.toString(),
                    style: context.theme.textTheme.titleLarge?.bold,
                  ),
                ),
                MediaCards(
                  listType: listSetting,
                  primary: false,
                  shrinkWrap: true,
                  padding: listSetting == ListType.grid
                      ? const EdgeInsets.all(8)
                      : null,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: GridCard.listRatio,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    var media = year.medias[index];

                    return buildMediaCard(listSetting, media, context);
                  },
                  itemCount: year.medias.length,
                ),
              ],
            );
          },
          itemCount: years.length,
        );
      default:
        return MediaCards(
          listType: listSetting,
          padding: listSetting == ListType.grid
              ? const EdgeInsets.all(8)
              : null,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: GridCard.listRatio,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final media = widget.medias.edges![index]!;

            return buildMediaCard(listSetting, media, context);
          },
          itemCount: widget.medias.edges!.length,
        );
    }
  }

  MediaCard buildMediaCard(
    ListType listSetting,
    Query$Staff$Staff$characterMedia$edges media,
    BuildContext context,
  ) {
    return MediaCard(
      listType: listSetting,
      image: media.characters!.first!.image!.large!,
      title: media.characters!.first!.name!.userPreferred,
      onLongPress: () => showModalBottomSheet(
        context: context,
        builder: (context) => ListView(
          padding: .all(8),
          children: [
            Row(
              crossAxisAlignment: .start,
              children: [
                ClipRRect(
                  borderRadius: imageRadius,
                  child: CachedImage(
                    media.characters!.first!.image!.large!,
                    height: 150,
                    width: 106,
                    fit: .fill,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const .all(8.0),
                    child: Text(media.characters!.first!.name!.userPreferred!),
                  ),
                ),
              ],
            ),
            Card.outlined(
              child: InkWell(
                borderRadius: imageRadius,
                onLongPress: () => MediaSheet.show(context, media.node!),
                onTap: () => context.push(Routes.media(media.node!.id)),
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    ClipRRect(
                      borderRadius: imageRadius,
                      child: CachedImage(
                        media.node!.coverImage!.extraLarge!,
                        height: 120,
                        width: 85,
                        fit: .fill,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const .all(8),
                        child: Text(
                          media.node!.title!.userPreferred!,
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () => context.push(
        Routes.character(media.characters!.first!.id),
        extra: {"placeholder": media.characters!.fold},
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// used to sort media by year
class _Media {
  const _Media(this.medias, this.year);

  final List<Query$Staff$Staff$characterMedia$edges> medias;
  final int year;

  static List<_Media> sort(
    Iterable<Query$Staff$Staff$characterMedia$edges?> edges, [
    bool unknownAtStart = true,
  ]) {
    List<_Media> list = [];
    final _Media tbas = _Media([], 0);

    for (var edge in edges) {
      var index = list.indexWhere(
        (element) => element.year == edge!.node!.startDate?.year,
      );

      if (index != -1) {
        list[index].medias.add(edge!);
      } else if (edge!.node!.startDate?.year == null) {
        tbas.medias.add(edge);
      } else {
        // print(edge.node!.title!.userPreferred);
        list.add(_Media([edge], edge.node!.startDate!.year!));
      }
    }

    if (unknownAtStart && tbas.medias.isNotEmpty)
      list.insert(0, tbas);
    else if (tbas.medias.isNotEmpty)
      list.add(tbas);

    return list;
  }
}
