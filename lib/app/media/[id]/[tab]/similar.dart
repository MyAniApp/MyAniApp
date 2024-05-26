import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/app/media/__generated__/similar.req.gql.dart';
import 'package:myaniapp/common/media_cards/grid_card.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/graphql/widget.dart';

class MediaSimilarPage extends StatefulWidget {
  const MediaSimilarPage({super.key, required this.mediaId});

  final int mediaId;

  @override
  State<MediaSimilarPage> createState() => _MediaSimilarPageState();
}

class _MediaSimilarPageState extends State<MediaSimilarPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GQLRequest(
      operationRequest: GMediaSimilarReq((b) => b
        ..requestId = "mediaSimilar${widget.mediaId}"
        ..vars.mediaId = widget.mediaId),
      builder: (context, response, error, refetch) => GraphqlPagination(
        pageInfo: response!.data!.Media!.recommendations!.pageInfo!,
        req: (nextPage) =>
            (response.operationRequest as GMediaSimilarReq).rebuild(
          (p0) => p0
            ..vars.page = nextPage
            ..updateResult = (previous, result) => result?.rebuild((p0) => p0
              ..Media.recommendations.nodes.insertAll(
                  0,
                  previous?.Media?.recommendations?.nodes?.whereNot((p0) =>
                          result.Media?.recommendations?.nodes?.contains(p0) ??
                          false) ??
                      [])),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: GridCard.listRatio,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            var media0 = response.data!.Media!.recommendations!.nodes![index]!
                .mediaRecommendation!;

            return GridCard(
              image: media0.coverImage!.extraLarge!,
              title: media0.title!.userPreferred,
              blur: media0.isAdult ?? false,
              onTap: () => context.push("/media/${media0.id}/overview",
                  extra: {"media": media0}),
              onLongPress: () => MediaSheet.show(context, media0),
            );
          },
          itemCount: response.data!.Media!.recommendations!.nodes!.length,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
