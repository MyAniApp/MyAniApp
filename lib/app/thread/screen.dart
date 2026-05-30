import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp/app/home/forum/screen.dart';
import 'package:myaniapp/common/banner_ad.dart';
import 'package:myaniapp/common/comment.dart';
import 'package:myaniapp/common/hiding_floating_button.dart';
import 'package:myaniapp/common/markdown/markdown.dart';
import 'package:myaniapp/common/markdown_editor.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/common/show.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/fragments/thread.graphql.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/__gen/thread.graphql.dart';
import 'package:myaniapp/graphql/mutations.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/common/gql_widget.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/routes.dart';
import 'package:myaniapp/utils.dart';
import 'package:mygraphql/graphql.dart';
import 'package:url_launcher/url_launcher.dart';

class ThreadScreen extends HookConsumerWidget {
  ThreadScreen({super.key, required this.id, this.placeholder});

  final int id;
  final Fragment$ThreadFragment? placeholder;

  final dataKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var scrollController = useScrollController();
    var (:snapshot, :fetchMore, :refetch) = gqlClient.useQuery(
      GQLRequest(
        threadQuery,
        variables: Variables$Query$Thread(id: id).toJson(),
        parseData: Query$Thread.fromJson,
        mergeResults: defaultMergeResults("comments.threadComments"),
      ),
    );

    return GQLWidget(
      refetch: refetch,
      response: snapshot,
      loading: null,
      error: Scaffold(
        appBar: AppBar(),
        body: GraphqlError(
          exception: (snapshot.errors, snapshot.linkError),
          refetch: refetch,
        ),
      ),
      builder: () {
        if (snapshot.loading == true && placeholder == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        var threadData = snapshot.parsedData?.thread;

        final view = CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              title: Text((threadData ?? placeholder)!.title!),
            ),
            SliverToBoxAdapter(
              child: Card(
                child: Comment(
                  key: dataKey,
                  collapsible: false,
                  decoration: BoxDecoration(),
                  avatar: (threadData ?? placeholder)!.user!.avatar!.large!,
                  username: (threadData ?? placeholder)!.user!.name,
                  createdAt: (threadData ?? placeholder)!.createdAt,
                  onAvatarTap: () => context.push(
                    Routes.user((threadData ?? placeholder)!.user!.name),
                    extra: {"placeholder": (threadData ?? placeholder)!.user},
                  ),
                  body: Show(
                    when: threadData != null,
                    fallback: const SizedBox(height: 150),
                    child: () => MarkdownWidget.body(
                      data: threadData!.body!,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      selectable: true,
                    ),
                  ),
                  footer: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var cat
                                  in (threadData ?? placeholder)!.categories!)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: ActionChip(
                                    label: Text(cat!.name),
                                    onPressed: () => context.push(
                                      Routes.forums(
                                        ForumTabs.recent,
                                        category: cat.id,
                                      ),
                                    ),
                                  ),
                                ),
                              for (var cat
                                  in (threadData ?? placeholder)!
                                      .mediaCategories!)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: ActionChip(
                                    label: Text(cat!.title!.userPreferred!),
                                    onPressed: () => context.push(
                                      Routes.media(cat.id),
                                      extra: {"placeholder": cat},
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (threadData != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 4,
                            ),
                            child: Row(
                              children: [
                                CommentLikeButton(
                                  isLiked: threadData.isLiked == true,
                                  likeCount: threadData.likeCount,
                                  id: threadData.id,
                                  type: .THREAD,
                                  onPressed: requiredLogin(
                                    ref,
                                    "like an activity",
                                    () =>
                                        mutationToggleLike(
                                          Enum$LikeableType.THREAD,
                                          threadData.id,
                                        ).then(
                                          (_) => refetch(FetchPolicy.cacheOnly),
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                IconButton(
                                  onPressed: requiredLogin(
                                    ref,
                                    "subscribe to an activity",
                                    () =>
                                        mutationToggleSubscription(
                                          .thread,
                                          threadData.id,
                                          !(threadData.isSubscribed ?? false),
                                        ).then(
                                          (_) => refetch(FetchPolicy.cacheOnly),
                                        ),
                                  ),
                                  icon: Icon(
                                    threadData.isSubscribed == true
                                        ? Icons.notifications_active
                                        : Icons.notifications_outlined,
                                    color: (threadData.isSubscribed ?? false)
                                        ? Colors.yellow
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: BannerAdWidget(location: .thread)),
            if (threadData?.isLocked == false)
              SliverAppBar(
                primary: false,
                automaticallyImplyLeading: false,
                pinned: true,
                surfaceTintColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: InkWell(
                    onTap: () => MarkdownEditor.show(
                      context,
                      hint: "Write a reply",
                      onSave: (text) => mutationSaveComment(
                        text,
                        threadId: id,
                      ).then((value) => refetch()),
                      leading: Comment(
                        collapsible: false,
                        avatar:
                            (threadData ?? placeholder)!.user!.avatar!.large!,
                        username: (threadData ?? placeholder)!.user!.name,
                        createdAt: (threadData ?? placeholder)!.createdAt,
                        body: MarkdownWidget.body(
                          data: threadData!.body!,
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                            bottom: 8,
                          ),
                          selectable: true,
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: context
                                .theme
                                .colorScheme
                                .surfaceContainerHighest,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Post a reply",
                            style: context.theme.textTheme.bodyLarge?.copyWith(
                              color: context.theme.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Show(
              when: threadData != null,
              fallback: SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator.adaptive()),
              ),
              child: () => SliverList.builder(
                itemBuilder: (context, index) {
                  var comment =
                      snapshot.parsedData!.comments!.threadComments![index]!;

                  return ThreadComment(
                    id: comment.id,
                    parentId: comment.id,
                    avatar: comment.user?.avatar?.large,
                    username: comment.user?.name ?? "unknown",
                    comment: comment.comment!,
                    createdAt: comment.createdAt,
                    replies: comment.childComments,
                    isLiked: comment.isLiked ?? false,
                    likeCount: comment.likeCount,
                    refetch: refetch,
                    donatorText: comment.user?.donatorTier != 0
                        ? comment.user?.donatorBadge
                        : null,
                    modRoles: comment.user?.moderatorRoles?.fold(
                      [],
                      (previousValue, element) => [
                        ...?previousValue,
                        element!.name.capitalize(),
                      ],
                    ),
                  );
                },
                itemCount:
                    snapshot.parsedData!.comments!.threadComments!.length,
              ),
            ),
          ],
        );

        return HidingFloatingButton(
          button: Container(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surface,
              borderRadius: imageRadius,
            ),
            width: 130,
            child: Show(
              when:
                  (snapshot.parsedData?.comments?.pageInfo?.lastPage ?? 0) > 1,
              child: () => DropdownMenu(
                initialSelection:
                    (snapshot.parsedData?.comments?.pageInfo?.currentPage ?? 0),
                label: Text(
                  "Page",
                  style: TextStyle(
                    backgroundColor: context.theme.colorScheme.surface,
                  ),
                ),
                onSelected: (selected) {
                  if (snapshot.parsedData!.comments!.pageInfo!.currentPage ==
                      selected) {
                    return;
                  }
                  fetchMore(
                    variables: Variables$Query$Thread.fromJson(
                      snapshot.request!.variables,
                    ).copyWith(page: selected).toJson(),
                    mergeResults: (previousResult, result) => result,
                  );
                  if (dataKey.currentContext?.mounted == true) {
                    scrollController.jumpTo(
                      dataKey.currentContext!.size!.height,
                    );
                  }
                },
                inputDecorationTheme: const InputDecorationTheme(
                  border: OutlineInputBorder(borderRadius: imageRadius),
                ),
                dropdownMenuEntries: [
                  for (
                    int i = 1;
                    i <=
                        (snapshot.parsedData!.comments!.pageInfo!.lastPage ??
                            1);
                    i++
                  )
                    DropdownMenuEntry(value: i, label: i.toString()),
                ],
              ),
            ),
          ),
          builder: (button) => Scaffold(
            floatingActionButton: button,
            body: Show(
              when: threadData != null,
              fallback: view,
              child: () => GraphqlPagination(
                pageInfo: snapshot.parsedData!.comments!.pageInfo!,
                req: (nextPage) => fetchMore(
                  variables: Variables$Query$Thread.fromJson(
                    snapshot.request!.variables,
                  ).copyWith(page: nextPage).toJson(),
                ),
                child: view,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ThreadComment extends HookConsumerWidget {
  const ThreadComment({
    super.key,
    required this.comment,
    required this.username,
    required this.createdAt,
    required this.isLiked,
    required this.id,
    required this.likeCount,
    required this.refetch,
    required this.parentId,
    this.replies,
    this.isReply,
    this.donatorText,
    this.modRoles,
    String? avatar,
    int? depth,
  }) : this.avatar = avatar ?? anilistDefaultImage,
       this.depth = depth ?? 1;

  final int id;
  final int parentId;
  final String avatar;
  final String username;
  final int createdAt;
  final String comment;
  final dynamic replies;
  final bool? isReply;
  final bool isLiked;
  final int likeCount;
  final QueryRefetch refetch;
  final String? donatorText;
  final List<String>? modRoles;
  final int depth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depthState = useState(depth % 20 != 0);
    List<Query$Thread$comments$threadComments> parsedReplies = useMemoized(() {
      try {
        List<Query$Thread$comments$threadComments> list = [];
        if (replies != null) {
          for (var reply in replies) {
            if (reply == null) continue;

            // holy i have no idea why "Query$Thread$comments$threadComments.fromJson" cant be used bc it errors
            // for the first few seconds of the render then "Query$Thread$comments$threadComments.fromJson(reply)" works
            // but that leaves a little amount of time where replies dont load
            // basically doing "Query$Thread$comments$threadComments.fromJson" manually works
            // same goes for "Query$Thread$comments$threadComments$user.fromJson"
            //
            // Error is "_Map is not sub type of Map in type cast"

            list.add(
              Query$Thread$comments$threadComments(
                id: reply['id'],
                createdAt: reply['createdAt'],
                likeCount: reply['likeCount'],
                comment: reply['comment'],
                isLiked: reply['isLiked'],
                isLocked: reply['isLocked'],
                threadId: reply['threadId'],
                childComments: reply['childComments'],
                user: reply['user'] != null
                    ? Query$Thread$comments$threadComments$user(
                        id: reply['user']?['id'],
                        name: reply['user']?['name'],
                        avatar:
                            Query$Thread$comments$threadComments$user$avatar(
                              large: reply['user']?['avatar']?['large'],
                            ),
                        donatorTier: reply['user']?['donatorTier'],
                        donatorBadge: reply['user']?['donatorBadge'],
                        moderatorRoles:
                            (reply['user']?['moderatorRoles'] as List<dynamic>?)
                                ?.map(
                                  (e) => e == null
                                      ? null
                                      : fromJson$Enum$ModRole((e as String)),
                                )
                                .toList(),
                      )
                    : null,
              ),
            );
          }
        }
        return list;
      } catch (err) {
        return [];
      }
    }, [replies]);

    return Comment(
      badge: [
        if (modRoles?.isNotEmpty == true) CommentBadge(text: modRoles!),
        if (donatorText != null) CommentBadge(text: [donatorText!]),
      ],
      collapsible: true,
      avatar: avatar,
      username: username,
      createdAt: createdAt,
      isReply: isReply ?? false,
      onAvatarTap: () => context.push(Routes.user(username)),
      body: MarkdownWidget.body(
        data: comment,
        selectable: true,
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      replies: [
        if (parsedReplies.isNotEmpty == true && depthState.value)
          for (var reply in parsedReplies)
            ThreadComment(
              id: reply.id,
              parentId: id,
              avatar: reply.user?.avatar?.large ?? anilistDefaultImage,
              username: reply.user?.name ?? "unknown",
              createdAt: reply.createdAt,
              comment: reply.comment!,
              replies: reply.childComments,
              isLiked: reply.isLiked ?? false,
              likeCount: reply.likeCount,
              isReply: true,
              refetch: refetch,
              depth: depth + 1,
              donatorText: reply.user?.donatorTier != 0
                  ? reply.user?.donatorBadge
                  : null,
              modRoles: reply.user?.moderatorRoles?.fold(
                [],
                (previousValue, element) => [
                  ...?previousValue,
                  element!.name.capitalize(),
                ],
              ),
            )
        else if (parsedReplies.isNotEmpty)
          TextButton(
            child: Text('Show replies'),
            onPressed: () => depthState.value = true,
          ),
      ],
      footer: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            CommentLikeButton(
              isLiked: isLiked == true,
              likeCount: likeCount,
              id: id,
              type: .THREAD_COMMENT,
              onPressed: requiredLogin(
                ref,
                "like a comment",
                () => mutationToggleLike(.THREAD_COMMENT, id).then((value) {
                  if (isReply == true) {
                    refetch();
                  } else {
                    refetch(FetchPolicy.cacheFirst);
                  }
                }),
              ),
            ),
            TextButton.icon(
              label: SizedBox(),
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(
                  context.theme.colorScheme.onSurface,
                ),
              ),
              onPressed: requiredLogin(
                ref,
                "post a reply",
                () => MarkdownEditor.show(
                  context,
                  hint: "Write a reply",
                  onSave: (text) => mutationSaveComment(
                    text,
                    parentCommentId: id,
                  ).then((value) => refetch()),
                  leading: Comment(
                    collapsible: false,
                    avatar: avatar,
                    username: username,
                    createdAt: createdAt,
                    body: MarkdownWidget.body(
                      data: comment,
                      selectable: true,
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        bottom: 8,
                      ),
                    ),
                  ),
                ),
              ),
              icon: const Icon(Icons.reply),
            ),
          ],
        ),
      ),
    );
  }
}
