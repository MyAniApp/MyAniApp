import 'package:myaniapp/graphql/__gen/activity.graphql.dart';
import 'package:myaniapp/graphql/__gen/home_activities.graphql.dart';
import 'package:myaniapp/graphql/__gen/media.graphql.dart';
import 'package:myaniapp/graphql/__gen/recommendations.graphql.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/__gen/thread.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/main.dart';
import 'package:mygraphql/graphql.dart';

Future<GQLResponse> mutationToggleLike(Enum$LikeableType type, int id) {
  return gqlClient
      .query(
        GQLRequest(
          toggleLikeQuery,
          variables: Variables$Mutation$ToggleLike(id: id, type: type).toJson(),
        ),
      )
      .last;
}

enum ToggableSubscripition { activity, thread }

Future<GQLResponse> mutationToggleSubscription(
  ToggableSubscripition type,
  int id,
  bool isSubscribed,
) {
  return switch (type) {
    ToggableSubscripition.thread =>
      gqlClient
          .query(
            GQLRequest(
              toggleThreadSubscriptionQuery,
              variables: Variables$Mutation$ToggleThreadSubscription(
                id: id,
                subscribe: isSubscribed,
              ).toJson(),
            ),
          )
          .last,
    ToggableSubscripition.activity =>
      gqlClient
          .query(
            GQLRequest(
              toggleActivitySubscriptionQuery,
              variables: Variables$Mutation$ToggleActivitySubscription(
                id: id,
                subscribe: isSubscribed,
              ).toJson(),
            ),
          )
          .last,
  };
}

Future<GQLResponse> mutationSaveComment(
  String text, {
  int? parentCommentId,
  int? threadId,
}) {
  return gqlClient
      .query(
        GQLRequest(
          saveCommentQuery,
          variables: Variables$Mutation$SaveComment(
            comment: text,
            threadId: threadId,
            parentCommentId: parentCommentId,
          ).toJson(),
        ),
      )
      .last;
}

Future<GQLResponse> mutationSaveTextActivity(String text) {
  return gqlClient
      .query(
        GQLRequest(
          saveTextActivityQuery,
          variables: Variables$Mutation$SaveTextActivity(text: text).toJson(),
        ),
      )
      .last;
}

Future<GQLResponse> mutationSaveActivityReply(int id, String text) {
  return gqlClient
      .query(
        GQLRequest(
          saveActivityReplyQuery,
          variables: Variables$Mutation$SaveActivityReply(
            text: text,
            activityId: id,
          ).toJson(),
        ),
      )
      .last;
}

Future<GQLResponse> mutationToggleFavorite({
  int? animeId,
  int? mangaId,
  int? characterId,
  int? staffId,
  int? studioId,
}) {
  return gqlClient
      .query(
        GQLRequest(
          toggleFavoriteQuery,
          variables: Variables$Mutation$ToggleFavorite(
            characterId: characterId,
            animeId: animeId,
            mangaId: mangaId,
            staffId: staffId,
            studioId: staffId,
          ).toJson(),
        ),
      )
      .last;
}

Future<GQLResponse> mutationSaveRecommendation(
  int mediaId,
  int mediaRecId,
  Enum$RecommendationRating rating,
) {
  return gqlClient
      .query(
        GQLRequest(
          saveRecommendationQuery,
          variables: Variables$Mutation$SaveRecommendation(
            mediaId: mediaId,
            mediaRecommendationId: mediaRecId,
            rating: rating,
          ).toJson(),
        ),
      )
      .last;
}
