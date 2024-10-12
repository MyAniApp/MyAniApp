import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myaniapp/app/home/home.dart';
import 'package:myaniapp/common/media_cards/grid_card.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/app/recommendations/recommendations.graphql.dart';
import 'package:myaniapp/graphql/__gen/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/graphql/widget.dart';
import 'package:myaniapp/router.gr.dart';
import 'package:mygraphql/graphql.dart';

@RoutePage()
class RecommendationsScreen extends StatefulHookWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsStatePage();
}

class _RecommendationsStatePage extends State<RecommendationsScreen> {
  bool onMyList = false;
  Enum$RecommendationSort sort = Enum$RecommendationSort.ID_DESC;

  @override
  Widget build(BuildContext context) {
    var (:snapshot, :fetchMore, :refetch) = c.useQuery(GQLRequest(
      recommendationsQuery,
      variables: Variables$Query$Recommendations(onList: onMyList, sort: [sort])
          .toJson(),
      parseData: Query$Recommendations.fromJson,
      mergeResults: defaultMergeResults("Page.recommendations"),
    ));

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Row(
                children: [
                  SegmentedButton(
                    segments: const [
                      ButtonSegment(
                        value: false,
                        label: Text("All"),
                      ),
                      ButtonSegment(
                        value: true,
                        label: Text(
                          "My List",
                        ),
                      ),
                    ],
                    selected: {onMyList},
                    onSelectionChanged: (p0) =>
                        setState(() => onMyList = p0.first),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SegmentedButton<Enum$RecommendationSort>(
                    segments: const [
                      ButtonSegment(
                        value: Enum$RecommendationSort.ID_DESC,
                        label: Text('Recent'),
                      ),
                      ButtonSegment(
                        value: Enum$RecommendationSort.RATING_DESC,
                        label: Text('Highest Rated'),
                      ),
                      ButtonSegment(
                        value: Enum$RecommendationSort.RATING,
                        label: Text('Lowest Rated'),
                      )
                    ],
                    selected: {sort},
                    onSelectionChanged: (p0) => setState(() => sort = p0.first),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: GQLWidget(
        refetch: refetch,
        response: snapshot,
        builder: () => RefreshIndicator.adaptive(
          onRefresh: refetch,
          child: PaginationView.grid(
            pageInfo: snapshot!.parsedData!.Page!.pageInfo!,
            req: (nextPage) => fetchMore(
              variables: Variables$Query$Recommendations.fromJson(
                      snapshot.request!.variables)
                  .copyWith(page: nextPage)
                  .toJson(),
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              mainAxisExtent: 170,
            ),
            builder: (context, index) {
              var rec = snapshot.parsedData!.Page!.recommendations![index]!;
              if (rec.media == null || rec.mediaRecommendation == null) {
                return const SizedBox();
              }

              return Card.outlined(
                child: Stack(
                  // alignment: Alignment.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 130,
                            width: 85,
                            child: GridCard(
                              image: rec.media!.coverImage!.extraLarge!,
                              title: rec.media!.title!.userPreferred,
                              blur: rec.media!.isAdult ?? false,
                              onTap: () => context.pushRoute(MediaRoute(
                                id: rec.media!.id,
                                placeholder: rec.media!,
                              )),
                              onLongPress: () =>
                                  MediaSheet.show(context, rec.media!),
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 85,
                            child: GridCard(
                              image: rec
                                  .mediaRecommendation!.coverImage!.extraLarge!,
                              title:
                                  rec.mediaRecommendation!.title!.userPreferred,
                              blur: rec.mediaRecommendation!.isAdult ?? false,
                              onTap: () => context.pushRoute(MediaRoute(
                                id: rec.mediaRecommendation!.id,
                                placeholder: rec.mediaRecommendation,
                              )),
                              onLongPress: () => MediaSheet.show(
                                  context, rec.mediaRecommendation!),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.surfaceContainerHigh
                              .withOpacity(.5),
                          borderRadius: imageRadius,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.thumb_up),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.thumb_down),
                                ),
                              ],
                            ),
                            Text(
                                "${(rec.rating ?? 0) > 0 ? "+ " : ""}${(rec.rating ?? 0)}")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: snapshot.parsedData!.Page!.recommendations!.length,
          ),
        ),
      ),
    );
  }
}
