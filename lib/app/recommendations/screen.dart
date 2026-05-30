import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/media_cards/grid_card.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/recommendations.graphql.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/mutations.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/common/gql_widget.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/routes.dart';
import 'package:myaniapp/utils.dart';
import 'package:mygraphql/graphql.dart';

class RecommendationsScreen extends StatefulHookConsumerWidget {
  const RecommendationsScreen({super.key});

  @override
  ConsumerState<RecommendationsScreen> createState() =>
      _RecommendationsStatePage();
}

class _RecommendationsStatePage extends ConsumerState<RecommendationsScreen> {
  bool onMyList = false;
  Enum$RecommendationSort sort = Enum$RecommendationSort.ID_DESC;

  @override
  Widget build(BuildContext context) {
    var (:snapshot, :fetchMore, :refetch) = gqlClient.useQuery(
      GQLRequest(
        recommendationsQuery,
        variables: Variables$Query$Recommendations(
          onList: onMyList,
          sort: [sort],
        ).toJson(),
        parseData: (json) {
          final recs = Query$Recommendations.fromJson(json);
          if (hideAdultContent) {
            return recs.copyWith(
              Page: recs.Page?.copyWith(
                recommendations: recs.Page?.recommendations
                    ?.whereNot(
                      (r) =>
                          r?.media?.isAdult == true ||
                          r?.mediaRecommendation?.isAdult == true,
                    )
                    .toList(),
              ),
            );
          }
          return recs;
        },
        mergeResults: defaultMergeResults("Page.recommendations"),
      ),
    );

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
                      ButtonSegment(value: false, label: Text("All")),
                      ButtonSegment(value: true, label: Text("My List")),
                    ],
                    selected: {onMyList},
                    onSelectionChanged: (p0) =>
                        setState(() => onMyList = p0.first),
                  ),
                  const SizedBox(width: 10),
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
                      ),
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
            pageInfo: snapshot.parsedData!.Page!.pageInfo!,
            req: (nextPage) => fetchMore(
              variables: Variables$Query$Recommendations.fromJson(
                snapshot.request!.variables,
              ).copyWith(page: nextPage).toJson(),
            ),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 350,
              mainAxisExtent: 200,
            ),
            itemBuilder: (context, index) {
              var rec = snapshot.parsedData!.Page!.recommendations![index]!;
              if (rec.media == null || rec.mediaRecommendation == null) {
                return const SizedBox();
              }

              return Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 90,
                            child: GridCard(
                              image: rec.media!.coverImage!.extraLarge!,
                              title: rec.media!.title!.userPreferred,
                              blur: rec.media!.isAdult ?? false,
                              onTap: () => context.push(
                                Routes.media(rec.media!.id),
                                extra: {"placeholder": rec.media},
                              ),
                              onLongPress: () =>
                                  MediaSheet.show(context, rec.media!),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 130,
                            width: 90,
                            child: GridCard(
                              image: rec
                                  .mediaRecommendation!
                                  .coverImage!
                                  .extraLarge!,
                              title:
                                  rec.mediaRecommendation!.title!.userPreferred,
                              blur: rec.mediaRecommendation!.isAdult ?? false,
                              onTap: () => context.push(
                                Routes.media(rec.mediaRecommendation!.id),
                                extra: {"placeholder": rec.mediaRecommendation},
                              ),
                              onLongPress: () => MediaSheet.show(
                                context,
                                rec.mediaRecommendation!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "${(rec.rating ?? 0) > 0 ? "+ " : ""}${(rec.rating ?? 0)}",
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: requiredLogin(
                              ref,
                              "to rate a recommendation",
                              () =>
                                  mutationSaveRecommendation(
                                    rec.media!.id,
                                    rec.mediaRecommendation!.id,
                                    rec.userRating ==
                                            Enum$RecommendationRating.RATE_UP
                                        ? Enum$RecommendationRating.NO_RATING
                                        : Enum$RecommendationRating.RATE_UP,
                                  ).then(
                                    (value) => refetch(FetchPolicy.cacheFirst),
                                  ),
                            ),
                            icon: Icon(
                              Icons.thumb_up,
                              color: rec.userRating == .RATE_UP
                                  ? Colors.green
                                  : null,
                            ),
                          ),
                          IconButton(
                            onPressed: requiredLogin(
                              ref,
                              "to rate a recommendation",
                              () =>
                                  mutationSaveRecommendation(
                                    rec.media!.id,
                                    rec.mediaRecommendation!.id,
                                    rec.userRating ==
                                            Enum$RecommendationRating.RATE_DOWN
                                        ? Enum$RecommendationRating.NO_RATING
                                        : Enum$RecommendationRating.RATE_DOWN,
                                  ).then(
                                    (value) => refetch(FetchPolicy.cacheFirst),
                                  ),
                            ),
                            icon: Icon(
                              Icons.thumb_down,
                              color: rec.userRating == .RATE_DOWN
                                  ? Colors.red
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );

              return Card(
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
                              onTap: () => context.push(
                                Routes.media(rec.media!.id),
                                extra: {"placeholder": rec.media},
                              ),
                              onLongPress: () =>
                                  MediaSheet.show(context, rec.media!),
                            ),
                          ),
                          SizedBox(
                            height: 130,
                            width: 85,
                            child: GridCard(
                              image: rec
                                  .mediaRecommendation!
                                  .coverImage!
                                  .extraLarge!,
                              title:
                                  rec.mediaRecommendation!.title!.userPreferred,
                              blur: rec.mediaRecommendation!.isAdult ?? false,
                              onTap: () => context.push(
                                Routes.media(rec.mediaRecommendation!.id),
                                extra: {"placeholder": rec.mediaRecommendation},
                              ),
                              onLongPress: () => MediaSheet.show(
                                context,
                                rec.mediaRecommendation!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: requiredLogin(
                                    ref,
                                    "to rate a recommendation",
                                    () => gqlClient
                                        .query(
                                          GQLRequest(
                                            saveRecommendationQuery,
                                            variables:
                                                Variables$Mutation$SaveRecommendation(
                                                  mediaId: rec.media!.id,
                                                  mediaRecommendationId: rec
                                                      .mediaRecommendation!
                                                      .id,
                                                  rating:
                                                      rec.userRating ==
                                                          Enum$RecommendationRating
                                                              .RATE_UP
                                                      ? Enum$RecommendationRating
                                                            .NO_RATING
                                                      : Enum$RecommendationRating
                                                            .RATE_UP,
                                                ).toJson(),
                                          ),
                                        )
                                        .last
                                        .then(
                                          (value) =>
                                              refetch(FetchPolicy.cacheFirst),
                                        ),
                                  ),
                                  icon: const Icon(Icons.thumb_up),
                                ),
                                IconButton(
                                  onPressed: requiredLogin(
                                    ref,
                                    "to rate a recommendation",
                                    () => gqlClient
                                        .query(
                                          GQLRequest(
                                            saveRecommendationQuery,
                                            variables:
                                                Variables$Mutation$SaveRecommendation(
                                                  mediaId: rec.media!.id,
                                                  mediaRecommendationId: rec
                                                      .mediaRecommendation!
                                                      .id,
                                                  rating:
                                                      rec.userRating ==
                                                          Enum$RecommendationRating
                                                              .RATE_DOWN
                                                      ? Enum$RecommendationRating
                                                            .NO_RATING
                                                      : Enum$RecommendationRating
                                                            .RATE_DOWN,
                                                ).toJson(),
                                          ),
                                        )
                                        .last
                                        .then(
                                          (value) =>
                                              refetch(FetchPolicy.cacheFirst),
                                        ),
                                  ),
                                  icon: const Icon(Icons.thumb_down),
                                ),
                              ],
                            ),
                            Text(
                              "${(rec.rating ?? 0) > 0 ? "+ " : ""}${(rec.rating ?? 0)}",
                            ),
                          ],
                        ),
                      ),
                    ),
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
