import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/common/list_tile_circle_avatar.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/common/show.dart';
import 'package:myaniapp/graphql/__gen/media_reviews.graphql.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/common/gql_widget.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/routes.dart';
import 'package:mygraphql/graphql.dart';

class MediaReviewsTab extends HookWidget {
  const MediaReviewsTab({super.key, required this.mediaId});

  final int mediaId;

  @override
  Widget build(BuildContext context) {
    var (:snapshot, :fetchMore, :refetch) = gqlClient.useQuery(
      GQLRequest(
        mediaReviewsQuery,
        variables: Variables$Query$MediaReviews(mediaId: mediaId).toJson(),
        parseData: Query$MediaReviews.fromJson,
        mergeResults: defaultMergeResults("Media.reviews"),
      ),
    );

    return GQLWidget(
      refetch: refetch,
      response: snapshot,
      builder: () => Show(
        when: snapshot.parsedData!.Media!.reviews!.nodes!.isNotEmpty,
        fallback: Center(child: Text("No reviews")),
        child: () => PaginationView.grid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 450,
            mainAxisExtent: 155,
          ),
          pageInfo: snapshot.parsedData!.Media!.reviews!.pageInfo!,
          req: (nextPage) => fetchMore(
            variables: Variables$Query$MediaReviews(
              mediaId: mediaId,
              page: nextPage,
            ).toJson(),
          ),
          itemCount: snapshot.parsedData!.Media!.reviews!.nodes!.length,
          itemBuilder: (context, index) {
            var review = snapshot.parsedData!.Media!.reviews!.nodes![index]!;

            return Card(
              child: InkWell(
                onTap: () => context.push(
                  Routes.review(review.id),
                  extra: {"placeholder": review},
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Row(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 50,
                              maxWidth: 50,
                            ),
                            child: ListTileCircleAvatar(
                              url: review.user!.avatar!.large!,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(review.user!.name),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(review.summary!, maxLines: 3),
                      ),
                      // Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            color:
                                review.userRating == Enum$ReviewRating.UP_VOTE
                                ? Colors.green
                                : null,
                          ),
                          SizedBox(width: 5),
                          Text((review.rating ?? 0).toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
