import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/activity/activity.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/activities/activities.graphql.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/providers/user/user.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/comment.dart';
import 'package:myaniapp/ui/common/delete.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/image.dart';
import 'package:myaniapp/ui/common/markdown/markdown.dart';
import 'package:myaniapp/ui/common/markdown_editor.dart';

@RoutePage()
class ActivityPage extends ConsumerWidget {
  const ActivityPage({super.key, @pathParam required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    return Query$Activity$Widget(
      options: Options$Query$Activity(
        variables: Variables$Query$Activity(id: id),
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
          return Scaffold(
            appBar: AppBar(),
            body: GraphqlError(exception: result.exception!),
          );
        }

        return Scaffold(
          appBar: AppBar(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (ref.read(userProvider).value == null) {
                showDialog(
                  context: context,
                  builder: (context) => const Dialog(
                    child: Text('Sign to to post!'),
                  ),
                );
              } else {
                showMarkdownEditor(
                  context,
                  onSave: (text) {
                    if (text.isNotEmpty) {
                      client.value.mutate$SaveActivityReply(
                        Options$Mutation$SaveActivityReply(
                          variables: Variables$Mutation$SaveActivityReply(
                            activityId: id,
                            text: text,
                          ),
                          onCompleted: (p0, p1) => refetch!(),
                        ),
                      );
                    }
                  },
                );
              }
            },
            child: const Icon(Icons.add),
          ),
          body: RefreshIndicator.adaptive(
            onRefresh: refetch!,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ActivityEntry(
                        activity: result.parsedData!.activity!,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Replies ${result.parsedData?.replies?.activityReplies?.length ?? 0}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SliverList.builder(
                  itemBuilder: (context, index) {
                    var reply =
                        result.parsedData!.replies!.activityReplies![index]!;

                    return Comment(
                      body: Markdown(
                        data: reply.text!,
                      ),
                      avatarUrl: reply.user?.avatar?.large,
                      createdAt: reply.createdAt,
                      username: reply.user?.name,
                      leading: Row(
                        children: [
                          if (reply.userId == user.value?.id) ...[
                            IconButton(
                              onPressed: () async {
                                var shouldDelete =
                                    await showDeleteDialog(context);
                                if (shouldDelete == true) {
                                  client.value.mutate$DeleteActivityReply(
                                    Options$Mutation$DeleteActivityReply(
                                      variables:
                                          Variables$Mutation$DeleteActivityReply(
                                        id: reply.id,
                                      ),
                                      onCompleted: (p0, p1) => refetch(),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            IconButton(
                              onPressed: () => showMarkdownEditor(
                                context,
                                text: reply.text,
                                onSave: (text) {
                                  if (text.length > 2) {
                                    client.value.mutate$SaveActivityReply(
                                      Options$Mutation$SaveActivityReply(
                                        variables:
                                            Variables$Mutation$SaveActivityReply(
                                          id: reply.id,
                                          text: text,
                                        ),
                                        onError: (error) => logger.e(error),
                                      ),
                                    );
                                  }
                                },
                              ),
                              icon: const Icon(Icons.edit),
                            ),
                          ],
                          IconButton(
                            icon: Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: (reply.isLiked ?? false)
                                      ? Colors.red
                                      : null,
                                ),
                                if (reply.likeCount > 0)
                                  Text(reply.likeCount.toString()),
                              ],
                            ),
                            onPressed: () => client.value.mutate$ToggleLike(
                              Options$Mutation$ToggleLike(
                                variables: Variables$Mutation$ToggleLike(
                                  id: reply.id,
                                  type: Enum$LikeableType.ACTIVITY_REPLY,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount:
                      result.parsedData!.replies!.activityReplies!.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ActivityEntry extends ConsumerWidget {
  const ActivityEntry({
    super.key,
    required this.activity,
  });

  final Query$Activity$activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    if (activity is Query$Activity$activity$$ListActivity) {
      // typings
      var e = activity as Query$Activity$activity$$ListActivity;
      return Comment(
        avatarUrl: e.user?.avatar?.large,
        username: e.user?.name,
        createdAt: e.createdAt,
        leading: Row(
          children: [
            if (e.userId == user.value?.id)
              IconButton(
                onPressed: () async {
                  var shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete == true) {
                    client.value.mutate$DeleteActivity(
                      Options$Mutation$DeleteActivity(
                        variables: Variables$Mutation$DeleteActivity(
                          id: e.id,
                        ),
                        onCompleted: (p0, p1) => context.popRoute(),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.delete),
              ),
            IconButton(
              icon: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: (e.isLiked ?? false) ? Colors.red : null,
                  ),
                  if (e.likeCount > 0) Text(e.likeCount.toString()),
                ],
              ),
              onPressed: () => client.value.mutate$ToggleLike(
                Options$Mutation$ToggleLike(
                  variables: Variables$Mutation$ToggleLike(
                    id: e.id,
                    type: Enum$LikeableType.ACTIVITY,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Row(
          children: [
            GestureDetector(
              onTap: () => context.router.push(MediaRoute(id: e.media!.id)),
              child: ClipRRect(
                borderRadius: imageRadius,
                child: CImage(
                  imageUrl: e.media!.coverImage!.extraLarge!,
                  height: 130,
                  width: 85,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: toBeginningOfSentenceCase(e.status),
                    ),
                    if (e.progress != null) TextSpan(text: ' ${e.progress} of'),
                    TextSpan(
                      text: ' ${e.media?.title?.userPreferred}',
                      style: const TextStyle(
                        color: linkColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.router.push(
                              MediaRoute(id: e.media!.id),
                            ),
                    ),
                  ],
                ),
                // '${item.status} ${item.media!.title!.userPreferred!}',
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      );
    } else if (activity is Query$Activity$activity$$TextActivity) {
      var e = activity as Query$Activity$activity$$TextActivity;
      return Comment(
        body: Markdown(
          data: e.text!,
        ),
        leading: Row(
          children: [
            if (e.userId == user.value?.id) ...[
              IconButton(
                onPressed: () async {
                  var shouldDelete = await showDeleteDialog(context);
                  if (shouldDelete == true) {
                    client.value.mutate$DeleteActivity(
                      Options$Mutation$DeleteActivity(
                        variables: Variables$Mutation$DeleteActivity(
                          id: e.id,
                        ),
                        onCompleted: (p0, p1) => context.popRoute(),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () => showMarkdownEditor(
                  context,
                  text: e.text,
                  onSave: (text) {
                    if (text.length > 2) {
                      client.value.mutate$SaveTextActivity(
                        Options$Mutation$SaveTextActivity(
                          variables: Variables$Mutation$SaveTextActivity(
                            id: e.id,
                            text: text,
                          ),
                          onError: (error) => logger.e(error),
                        ),
                      );
                    }
                  },
                ),
                icon: const Icon(Icons.edit),
              ),
            ],
            IconButton(
              icon: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: (e.isLiked ?? false) ? Colors.red : null,
                  ),
                  if (e.likeCount > 0) Text(e.likeCount.toString()),
                ],
              ),
              onPressed: () => client.value.mutate$ToggleLike(
                Options$Mutation$ToggleLike(
                  variables: Variables$Mutation$ToggleLike(
                    id: e.id,
                    type: Enum$LikeableType.ACTIVITY,
                  ),
                ),
              ),
            ),
          ],
        ),
        avatarUrl: e.user?.avatar?.large,
        username: e.user?.name,
        createdAt: e.createdAt,
      );
    } else if (activity is Query$Activity$activity$$MessageActivity) {
      var e = activity as Query$Activity$activity$$MessageActivity;
      return Comment(
        body: Markdown(
          data: e.message!,
          selectable: false,
        ),
        avatarUrl: e.messenger?.avatar?.large,
        username: e.messenger?.name,
        createdAt: e.createdAt,
        leading: IconButton(
          icon: Row(
            children: [
              Icon(
                Icons.favorite,
                color: (e.isLiked ?? false) ? Colors.red : null,
              ),
              if (e.likeCount > 0) Text(e.likeCount.toString()),
            ],
          ),
          onPressed: () => client.value.mutate$ToggleLike(
            Options$Mutation$ToggleLike(
              variables: Variables$Mutation$ToggleLike(
                id: e.id,
                type: Enum$LikeableType.ACTIVITY,
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
