import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/ink_well_image.dart';
import 'package:myaniapp/common/media_cards/grid_card.dart';
import 'package:myaniapp/common/media_cards/media_card.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/show.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/staff.graphql.dart';
import 'package:myaniapp/providers/list_settings.dart';
import 'package:myaniapp/routes.dart';

class StaffVARolesScreen extends ConsumerStatefulWidget {
  const StaffVARolesScreen({
    super.key,
    required this.medias,
  });

  final Query$Staff$Staff$characterMedia medias;

  @override
  ConsumerState<StaffVARolesScreen> createState() => _StaffVARolesScreenState();
}

class _StaffVARolesScreenState extends ConsumerState<StaffVARolesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var listSetting = ref.watch(listSettingsProvider.select(
      (value) => value.staffVA,
    ));

    var years = _Media.sort(widget.medias.edges!);

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
              padding:
                  listSetting == ListType.grid ? const EdgeInsets.all(8) : null,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: GridCard.listRatio,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                var media = year.medias[index];

                return MediaCard(
                  listType: listSetting,
                  image: media.characters!.first!.image!.large!,
                  title: media.characters!.first!.name!.userPreferred,
                  onTap: () => context.push(
                      Routes.character(media.characters!.first!.id),
                      extra: {"placeholder": media.characters!.fold}),
                  underTitle: Show(
                    when: listSetting == ListType.list,
                    fallback: Show(
                      when: listSetting == ListType.simple,
                      child: () => Text(media.node!.title!.userPreferred!),
                    ),
                    child: () => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 53,
                          child: InkWellImage(
                            onTap: () => context.push(
                                Routes.media(media.node!.id),
                                extra: {"placeholder": media.node}),
                            onLongPress: () =>
                                MediaSheet.show(context, media.node!),
                            child: AspectRatio(
                              aspectRatio: GridCard.listRatio,
                              child: CachedImage(
                                media.node!.coverImage!.extraLarge!,
                                height: 50,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            media.node!.title!.userPreferred!,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  chips: [
                    Positioned(
                      bottom: 15,
                      right: 0,
                      child: ConstrainedBox(
                        // height: 80,
                        // width: 53,
                        constraints:
                            BoxConstraints(maxWidth: 53, maxHeight: 80),
                        child: InkWellImage(
                          onTap: () => context.push(
                              Routes.media(media.node!.id),
                              extra: {"placeholder": media.node}),
                          onLongPress: () =>
                              MediaSheet.show(context, media.node!),
                          child: AspectRatio(
                            aspectRatio: GridCard.listRatio,
                            child: CachedImage(
                              media.node!.coverImage!.extraLarge!,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: year.medias.length,
            ),
          ],
        );
      },
      itemCount: years.length,
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
      Iterable<Query$Staff$Staff$characterMedia$edges?> edges) {
    List<_Media> list = [];

    for (var edge in edges) {
      var index = list
          .indexWhere((element) => element.year == edge!.node!.startDate?.year);

      if (index != -1) {
        list[index].medias.add(edge!);
      } else if (edge!.node!.startDate?.year == null) {
        var tba = list.indexWhere((element) => element.year == 0);

        if (tba != -1) {
          list[tba].medias.add(edge);
        } else {
          list.insert(0, _Media([edge], 0));
        }

        continue;
      } else {
        // print(edge.node!.title!.userPreferred);
        list.add(_Media([edge], edge.node!.startDate!.year!));
      }
    }

    return list;
  }
}
