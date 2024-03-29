import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/graphql/__generated__/schema.schema.gql.dart';
import 'package:myaniapp/providers/ferry.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:myaniapp/ui/common/cards/sheet_card.dart';
import 'package:myaniapp/ui/common/comment/comment.dart';
import 'package:myaniapp/ui/common/comment/like.dart';
import 'package:myaniapp/ui/common/custom_dropdown.dart';
import 'package:myaniapp/ui/common/dialogs/delete.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/hidden_floating_action_button.dart';
import 'package:myaniapp/ui/common/markdown/markdown.dart';
import 'package:myaniapp/ui/common/markdown_editor.dart';
import 'package:myaniapp/ui/common/pagination.dart';
import 'package:myaniapp/ui/routes/home/activities/__generated__/activities.req.gql.dart';
import 'package:myaniapp/ui/routes/thread/__generated__/thread.data.gql.dart';
import 'package:myaniapp/ui/routes/thread/__generated__/thread.req.gql.dart';
import 'package:myaniapp/utils/require_login.dart';

class ThreadPage extends ConsumerWidget {
  ThreadPage({super.key, required this.id});

  final int id;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GQLRequest(
      operationRequest: GThreadReq((b) => b
        ..requestId = "thread$id"
        ..vars.id = id),
      loading: Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      error: (response) => Scaffold(
        appBar: AppBar(),
        body: GraphqlError(
          exception: (response!.graphqlErrors, response.linkException),
        ),
      ),
      builder: (context, response, error, refetch) => Scaffold(
        appBar: AppBar(
          title: Text(
            response!.data!.thread!.title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
        ),
        floatingActionButton: HiddenFloatingActionButton(
          scrollController: _controller,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Theme.of(context).colorScheme.background,
                ),
                // height: 90,
                padding: const EdgeInsets.only(top: 10),
                child: SheetDropdownMenu(
                  values: [response.data!.comments!.pageInfo!.currentPage ?? 1],
                  items: List.generate(
                    response.data!.comments!.pageInfo!.lastPage ?? 1,
                    (index) => DropdownMenuEntry(
                      value: index + 1,
                      label: (index + 1).toString(),
                    ),
                  ),
                  isMulti: false,
                  label: "Page",
                  onChanged: (values) {
                    _controller.jumpTo(0);
                    ref.read(ferryClientProvider).requestController.add(
                        (response.operationRequest as GThreadReq)
                            .rebuild((p0) => p0
                              ..vars.page = values.first
                              ..updateResult = (p0, p1) => p1));
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: requireLogin(
                  ref,
                  'reply',
                  () => showMarkdownEditor(
                    context,
                    onSave: (text) {
                      if (text.length > 2) {
                        ref
                            .read(ferryClientProvider)
                            .request(GSaveCommentReq(
                              (b) => b
                                ..vars.comment = text
                                ..vars.threadId = response.data!.thread!.id,
                            ))
                            .first
                            .then((value) => refetch());
                      }
                    },
                  ),
                ),
                child: const Icon(Icons.reply),
              ),
            ],
          ),
        ),
        body: GraphqlPagination(
          req: (nextPage) => (response.operationRequest as GThreadReq).rebuild(
              (p0) => p0
                ..vars.page = nextPage
                ..updateResult = (prev, result) => result!.rebuild((p0) => p0
                    .comments.threadComments
                    .insertAll(0, prev?.comments?.threadComments ?? []))),
          pageInfo: response.data!.comments!.pageInfo!,
          child: CustomScrollView(
            controller: _controller,
            slivers: [
              SliverToBoxAdapter(
                child: Comment(
                  body: Markdown(
                    data: response.data!.thread!.body!,
                  ),
                  avatarUrl: response.data!.thread!.user?.avatar?.large,
                  username: response.data!.thread!.user?.name,
                  createdAt: response.data!.thread!.createdAt,
                  footer: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          LikeButton(
                            id: response.data!.thread!.id,
                            type: GLikeableType.THREAD,
                            icon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color:
                                      (response.data!.thread!.isLiked ?? false)
                                          ? Colors.red
                                          : null,
                                ),
                                if (response.data!.thread!.likeCount > 0)
                                  Text(response.data!.thread!.likeCount
                                      .toString()),
                              ],
                            ),
                            onPressed: requireLogin(
                              ref,
                              'like',
                              () => ref
                                  .read(ferryClientProvider)
                                  .request(GToggleLikeReq(
                                    (b) => b
                                      ..vars.id = response.data!.thread!.id
                                      ..vars.type = GLikeableType.THREAD,
                                  ))
                                  .first,
                            ),
                          ),
                          IconButton(
                            onPressed: requireLogin(
                              ref,
                              "subscribe",
                              () => ref
                                  .read(ferryClientProvider)
                                  .request(GToggleThreadSubscriptionReq(
                                    (b) => b
                                      ..vars.id = response.data!.thread!.id
                                      ..vars.subscribe = !(response
                                              .data!.thread!.isSubscribed ??
                                          false),
                                  ))
                                  .first,
                            ),
                            icon: Icon(
                              response.data!.thread!.isSubscribed == true
                                  ? Icons.notifications_active
                                  : Icons.notifications,
                              color: response.data!.thread!.isSubscribed == true
                                  ? Colors.yellow
                                  : null,
                            ),
                          )
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var category
                                in response.data!.thread!.categories!)
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: ActionChip(
                                  onPressed: () => context.push(
                                      "/forum/recent?category=${category.id}"),
                                  label: Text(category!.name),
                                  labelPadding: EdgeInsets.zero,
                                  labelStyle:
                                      Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            for (var media
                                in response.data!.thread!.mediaCategories!)
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: GestureDetector(
                                  onLongPress: () =>
                                      showMediaCard(context, media),
                                  child: ActionChip(
                                    onPressed: () =>
                                        context.push('/media/${media.id}'),
                                    label: Text(media!.title!.userPreferred!),
                                    labelPadding: EdgeInsets.zero,
                                    labelStyle:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList.builder(
                itemBuilder: (context, index) {
                  var comment =
                      response.data!.comments!.threadComments![index]!;

                  return ThreadComment(
                    comment: comment,
                    refetch: refetch,
                  );
                },
                itemCount: response.data!.comments!.threadComments!.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// remember to update this same class in comment/comment.dart
// for some reason using a fragment for thread comment its doesn't get replies
class ThreadComment extends ConsumerWidget {
  const ThreadComment({
    super.key,
    required this.comment,
    required this.refetch,
    this.isReply,
  });

  final GThreadData_comments_threadComments comment;
  final void Function() refetch;
  final bool? isReply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    List<GThreadData_comments_threadComments> replies = [];

    // print(comment.childComments);

    try {
      if (comment.childComments != null) {
        for (var reply in comment.childComments!.asList) {
          replies.add(GThreadData_comments_threadComments.fromJson(reply)!);
        }
      }
    } catch (err) {}

    return Comment(
      body: Markdown(data: comment.comment!),
      createdAt: comment.createdAt,
      avatarUrl: comment.user?.avatar?.large,
      username: comment.user?.name,
      isReply: isReply ?? false,
      footer: Row(
        children: [
          LikeButton(
            id: comment.id,
            type: GLikeableType.THREAD_COMMENT,
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
              () => ref
                  .read(ferryClientProvider)
                  .request(GToggleLikeReq(
                    (b) => b
                      ..vars.id = comment.id
                      ..vars.type = GLikeableType.THREAD_COMMENT,
                  ))
                  .first,
            ),
          ),
          IconButton(
            onPressed: requireLogin(
              ref,
              'reply',
              () => showMarkdownEditor(
                context,
                onSave: (text) {
                  if (text.length > 2) {
                    ref
                        .read(ferryClientProvider)
                        .request(GSaveCommentReq(
                          (b) => b
                            ..vars.comment = text
                            ..vars.parentCommentId = comment.id,
                        ))
                        .first
                        .then((value) => refetch());
                  }
                },
              ),
            ),
            icon: const Icon(Icons.reply),
          ),
          if (comment.user != null && comment.user!.id == user.value?.id)
            IconButton(
              onPressed: () => showDeleteDialog(context).then((value) {
                if (value == true) {
                  ref
                      .read(ferryClientProvider)
                      .request(GDeleteCommentReq(
                        (b) => b..vars.id = comment.id,
                      ))
                      .first
                      .then((value) => refetch());
                }
              }),
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      replies: [
        for (var reply in replies)
          ThreadComment(
            comment: reply,
            refetch: refetch,
            isReply: true,
          )
      ],
    );
  }
}
