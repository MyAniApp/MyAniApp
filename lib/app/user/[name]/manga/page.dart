import 'package:built_collection/built_collection.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:myaniapp/app/user/%5Bname%5D/anime/page.dart';
import 'package:myaniapp/common/lists/__generated__/lists.req.gql.dart';
import 'package:myaniapp/graphql/__generated__/schema.schema.gql.dart';
import 'package:myaniapp/graphql/fragments/__generated__/list_group.data.gql.dart';
import 'package:myaniapp/graphql/widget.dart';

class UserMangaPage extends StatelessWidget {
  const UserMangaPage({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return GQLRequest(
      loading: Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      error: (response) => Scaffold(
        appBar: AppBar(),
        body: GraphqlError(
          exception: (response?.graphqlErrors, response?.linkException),
          req: response?.operationRequest,
        ),
      ),
      operationRequest: GMediaListReq(
        (b) => b
          ..requestId = "mediaList$name"
          ..vars.userName = name
          ..vars.type = GMediaType.MANGA
          ..fetchPolicy = FetchPolicy.NoCache,
      ),
      builder: (context, response, error, refetch) {
        return RefreshIndicator.adaptive(
          onRefresh: refetch,
          notificationPredicate: (notification) => notification.depth == 1,
          child: MediaListView(
            onDelete: refetch,
            groups: response!.data!.MediaListCollection!.lists!
                .whereType<GListGroup>()
                .toBuiltList(),
            user: response.data!.MediaListCollection!.user!,
            type: GMediaType.ANIME,
          ),
        );
      },
    );
  }
}
