import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myaniapp/app/home/home.dart';
import 'package:myaniapp/app/home/page.dart';
import 'package:myaniapp/common/media_cards/grid_card.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/text_viewall_button.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/app/home/explore/explore.graphql.dart';
import 'package:myaniapp/graphql/__gen/graphql/fragments/media.graphql.dart';
import 'package:myaniapp/graphql/__gen/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/graphql/widget.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/router.gr.dart';
import 'package:mygraphql/graphql.dart';
// import 'package:myaniapp/graphql/widget.dart';

@RoutePage()
class ExploreScreen extends StatefulHookWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final (Enum$MediaSeason season, int year) season;
  late final (Enum$MediaSeason season, int year) nextSeason;

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    season = getSeason(now);
    nextSeason = getNextSeason(season);
  }

  @override
  Widget build(BuildContext context) {
    var (snapshot: data, fetchMore: _, :refetch) = c.useQuery(GQLRequest(
      exploreQuery,
      variables: Variables$Query$Explore(
        season: season.$1,
        seasonYear: season.$2,
        nextSeason: nextSeason.$1,
        nextYear: nextSeason.$2,
      ).toJson(),
      parseData: Query$Explore.fromJson,
    ));

    return Scaffold(
      appBar: AppBar(
        leading: const HomeLeadingIcon(),
      ),
      body: GQLWidget(
        response: data,
        refetch: refetch,
        builder: () => RefreshIndicator.adaptive(
          onRefresh: refetch,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  autofocus: false,
                  canRequestFocus: false,
                  decoration: const InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                  onTap: () => context.pushRoute(SearchRoute(autofocus: true)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SegmentedButton(
                          segments: const [
                            ButtonSegment(
                              value: 0,
                              icon: Icon(
                                Icons.thumb_up,
                                size: 17,
                              ),
                              label: Text('Search Media'),
                            ),
                            ButtonSegment(
                              value: 1,
                              icon: Icon(Icons.calendar_today),
                              label: Text('Search Staff'),
                            ),
                          ],
                          selected: const {9},
                          onSelectionChanged: (v) {
                            if (v.firstOrNull == 0) {
                              context.pushRoute(SearchRoute());
                            }
                            if (v.firstOrNull == 1) {
                              context.pushRoute(StaffSearchRoute());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SegmentedButton(
                          segments: const [
                            ButtonSegment(
                              value: 0,
                              icon: Icon(
                                Icons.thumb_up,
                                size: 17,
                              ),
                              label: Text('Recommendations'),
                            ),
                            ButtonSegment(
                              value: 1,
                              icon: Icon(Icons.calendar_today),
                              label: Text('Releases'),
                            ),
                          ],
                          selected: const {9},
                          onSelectionChanged: (v) {
                            if (v.firstOrNull == 0) {
                              context.pushRoute(const RecommendationsRoute());
                            }
                            if (v.firstOrNull == 1) {
                              context.pushRoute(const CalendarRoute());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _List(
                medias: data.parsedData!.trending!.media!,
                title: "Trending",
                onTap: () => context.router.pushNamed(
                    "/search/media?sort=${Enum$MediaSort.TRENDING_DESC.name}"),
              ),
              _List(
                medias: data.parsedData!.season!.media!,
                title: "Releasing This Season",
                onTap: () => context.router.pushNamed(
                    "/search/media?season=${season.$1.name}&year=${season.$2}"),
              ),
              _List(
                medias: data.parsedData!.nextSeason!.media!,
                title: "Releasing Next Season",
                onTap: () => context.router.pushNamed(
                    "/search/media?season=${nextSeason.$1.name}&year=${nextSeason.$2}"),
              ),
              _List(
                medias: data.parsedData!.popular!.media!,
                title: "All Time Popular",
                onTap: () => context.router.pushNamed(
                    "/search/media?sort=${Enum$MediaSort.POPULARITY_DESC.name}"),
              ),
              _List(
                medias: data.parsedData!.recent!.media!,
                title: "Recent",
                onTap: () => context.router.pushNamed(
                    "/search/media?sort=${Enum$MediaSort.ID_DESC.name}"),
              )
            ],
          ),
        ),
      ),
    );
  }

  (Enum$MediaSeason season, int year) getSeason(DateTime date) {
    var m = date.month;
    Enum$MediaSeason season = m >= 1 && m <= 3
        ? Enum$MediaSeason.WINTER
        : m >= 4 && m <= 6
            ? Enum$MediaSeason.SPRING
            : m >= 7 && m <= 9
                ? Enum$MediaSeason.SUMMER
                : Enum$MediaSeason.FALL;

    return (season, date.year);
  }

  (Enum$MediaSeason, int) getNextSeason((Enum$MediaSeason, int) season) {
    int year = DateTime(season.$2, DateTime.now().month + 3).year;

    return switch (season.$1) {
      Enum$MediaSeason.FALL => (Enum$MediaSeason.WINTER, year),
      Enum$MediaSeason.WINTER => (Enum$MediaSeason.SPRING, year),
      Enum$MediaSeason.SPRING => (Enum$MediaSeason.SUMMER, year),
      Enum$MediaSeason.SUMMER => (Enum$MediaSeason.FALL, year),
      _ => (Enum$MediaSeason.SUMMER, year),
    };
  }
}

class _List extends StatelessWidget {
  const _List({
    required this.medias,
    required this.title,
    required this.onTap,
  });

  final List<Fragment$MediaFragment?> medias;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextViewAllButton(title: title, onTap: onTap),
        ),
        SizedBox(
          height: 170,
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            primary: false,
            children: [
              for (var media in medias.take(10))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GridCard(
                    blur: media!.isAdult ?? false,
                    image: media.coverImage!.extraLarge!,
                    title: media.title!.userPreferred!,
                    onTap: () => context.pushRoute(
                        MediaRoute(id: media.id, placeholder: media)),
                    onLongPress: () => MediaSheet.show(context, media),
                    aspectRatio: GridCard.listRatio,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
