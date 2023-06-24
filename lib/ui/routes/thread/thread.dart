import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/activities/activities.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/thread/thread.graphql.dart';
import 'package:myaniapp/providers/user/user.dart';
import 'package:myaniapp/ui/common/comment.dart';
import 'package:myaniapp/ui/common/delete.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/markdown/markdown.dart';
import 'package:myaniapp/ui/common/markdown_editor.dart';
import 'package:myaniapp/ui/common/pagination.dart';
import 'package:myaniapp/utils/require_login.dart';

@RoutePage()
class ThreadPage extends ConsumerWidget {
  const ThreadPage({super.key, @PathParam('id') required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Query$Thread$Widget(
        options: Options$Query$Thread(
          variables: Variables$Query$Thread(id: id),
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading && result.parsedData == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          } else if (result.hasException) {
            return GraphqlError(exception: result.exception!);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(result.parsedData!.thread!.title!),
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: requireLogin(
                ref,
                'reply',
                () => showMarkdownEditor(
                  context,
                  onSave: (text) {
                    if (text.length > 2) {
                      client.value.mutate$SaveComment(
                        Options$Mutation$SaveComment(
                          variables: Variables$Mutation$SaveComment(
                            comment: text,
                            threadId: result.parsedData!.thread!.id,
                          ),
                          onCompleted: (p0, p1) => refetch,
                        ),
                      );
                    }
                  },
                ),
              ),
              child: const Icon(Icons.reply),
            ),
            body: Pagination(
              fetchMore: fetchMore!,
              pageInfo: result.parsedData!.comments!.pageInfo!,
              opts: FetchMoreOptions$Query$Thread(
                updateQuery: (previousResultData, fetchMoreResultData) {
                  var list = [
                    ...previousResultData!['comments']['threadComments'],
                    ...fetchMoreResultData!['comments']['threadComments']
                  ];

                  fetchMoreResultData['comments']['threadComments'] = list;

                  return fetchMoreResultData;
                },
                variables: Variables$Query$Thread(
                  page: (result.parsedData!.comments!.pageInfo!.currentPage ??
                          1) +
                      1,
                ),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Comment(
                          body:
                              Markdown(data: result.parsedData!.thread!.body!),
                          avatarUrl:
                              result.parsedData!.thread!.user!.avatar!.large!,
                          username: result.parsedData!.thread!.user!.name,
                          createdAt: result.parsedData!.thread!.createdAt,
                          leading: IconButton(
                            icon: Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: (result.parsedData!.thread!.isLiked ??
                                          false)
                                      ? Colors.red
                                      : null,
                                ),
                                if (result.parsedData!.thread!.likeCount > 0)
                                  Text(result.parsedData!.thread!.likeCount
                                      .toString()),
                              ],
                            ),
                            onPressed: requireLogin(
                              ref,
                              'like',
                              () => client.value.mutate$ToggleLike(
                                Options$Mutation$ToggleLike(
                                  variables: Variables$Mutation$ToggleLike(
                                    id: result.parsedData!.thread!.id,
                                    type: Enum$LikeableType.THREAD,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${result.parsedData!.thread!.replyCount ?? 0} Replies',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SliverList.builder(
                    itemBuilder: (context, index) {
                      var comment =
                          result.parsedData!.comments!.threadComments![index]!;

                      return ThreadComment(
                        comment: comment,
                        refetch: refetch!,
                      );
                    },
                    itemCount:
                        result.parsedData!.comments!.threadComments!.length,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ThreadComment extends ConsumerWidget {
  const ThreadComment({
    super.key,
    required this.comment,
    required this.refetch,
    this.isReply,
  });

  final Query$Thread$comments$threadComments comment;
  final void Function() refetch;
  final bool? isReply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    List<Query$Thread$comments$threadComments>? replies;

    try {
      replies = comment.childComments
          ?.map((comment) =>
              Query$Thread$comments$threadComments.fromJson(comment))
          .cast<Query$Thread$comments$threadComments>()
          .toList() as List<Query$Thread$comments$threadComments>?;
    } catch (err) {}

    return Comment(
      body: Markdown(data: comment.comment!),
      createdAt: comment.createdAt,
      avatarUrl: comment.user?.avatar?.large,
      username: comment.user?.name,
      isReply: isReply ?? false,
      leading: Row(
        children: [
          if (comment.user != null && comment.user!.id == user.value?.id)
            IconButton(
              onPressed: () => showDeleteDialog(context).then((value) {
                if (value == true) {
                  client.value.mutate$DeleteComment(
                    Options$Mutation$DeleteComment(
                      variables:
                          Variables$Mutation$DeleteComment(id: comment.id),
                      onCompleted: (p0, p1) => refetch,
                    ),
                  );
                }
              }),
              icon: const Icon(Icons.delete),
            ),
          IconButton(
            onPressed: requireLogin(
              ref,
              'reply',
              () => showMarkdownEditor(
                context,
                onSave: (text) {
                  if (text.length > 2) {
                    client.value.mutate$SaveComment(
                      Options$Mutation$SaveComment(
                        variables: Variables$Mutation$SaveComment(
                          comment: text,
                          parentCommentId: comment.id,
                        ),
                        onCompleted: (p0, p1) => refetch,
                      ),
                    );
                  }
                },
              ),
            ),
            icon: const Icon(Icons.reply),
          ),
          IconButton(
            icon: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: (comment.isLiked ?? false) ? Colors.red : null,
                ),
                if (comment.likeCount > 0) Text(comment.likeCount.toString()),
              ],
            ),
            onPressed: requireLogin(
              ref,
              'like',
              () => client.value.mutate$ToggleLike(
                Options$Mutation$ToggleLike(
                  variables: Variables$Mutation$ToggleLike(
                    id: comment.id,
                    type: Enum$LikeableType.THREAD_COMMENT,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      replies: replies
          ?.map(
            (e) => ThreadComment(
              comment: e,
              isReply: true,
              refetch: refetch,
            ),
          )
          .toList(),
    );
  }
}
