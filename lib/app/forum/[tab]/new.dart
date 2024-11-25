import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myaniapp/app/home/home.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/common/thread_card.dart';
import 'package:myaniapp/graphql/__gen/app/forum/forums.graphql.dart';
import 'package:myaniapp/graphql/__gen/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/graphql/widget.dart';
import 'package:myaniapp/main.dart';
import 'package:mygraphql/graphql.dart';

class ForumNewPage extends HookWidget {
  const ForumNewPage({super.key, this.categoryId});

  final int? categoryId;

  @override
  Widget build(BuildContext context) {
    var (:snapshot, :fetchMore, :refetch) = c.useQuery(GQLRequest(
      forumsQuery,
      variables: Variables$Query$Forums(
        id: categoryId,
        sort: [Enum$ThreadSort.CREATED_AT_DESC],
      ).toJson(),
      parseData: Query$Forums.fromJson,
      mergeResults: defaultMergeResults("Page.threads"),
    ));

    return GQLWidget(
      refetch: refetch,
      response: snapshot,
      builder: () => RefreshIndicator.adaptive(
        onRefresh: refetch,
        child: PaginationView.list(
          pageInfo: snapshot.parsedData!.Page!.pageInfo!,
          req: (nextPage) => fetchMore(
            variables:
                Variables$Query$Forums.fromJson(snapshot.request!.variables)
                    .copyWith(page: nextPage)
                    .toJson(),
          ),
          // child: ListView.builder(
          //   padding: const EdgeInsets.all(0),
          builder: (context, index) {
            var thread = snapshot.parsedData!.Page!.threads![index]!;

            return ThreadCard(thread: thread);
          },
          itemCount: snapshot.parsedData!.Page!.threads!.length,
        ),
      ),
    );
  }
}
