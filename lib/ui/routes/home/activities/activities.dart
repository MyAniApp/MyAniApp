import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/activities/activities.graphql.dart';
import 'package:myaniapp/providers/user/user.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/comment.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/image.dart';
import 'package:myaniapp/ui/common/markdown/markdown.dart';
import 'package:myaniapp/ui/common/markdown_editor.dart';
import 'package:myaniapp/ui/common/pagination.dart';
import 'package:myaniapp/ui/routes/home/app_bar.dart';
import 'package:myaniapp/utils/require_login.dart';

@RoutePage()
class HomeActivitiesPage extends ConsumerStatefulWidget {
  const HomeActivitiesPage({super.key});

  @override
  ConsumerState<HomeActivitiesPage> createState() => _HomeActivitiesPageState();
}

class _HomeActivitiesPageState extends ConsumerState<HomeActivitiesPage> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);

    return Query$Activities$Widget(
      options: Options$Query$Activities(
        variables: Variables$Query$Activities(
          isFollowing: isFollowing,
          hasReplies: !isFollowing,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
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
          appBar: HomeAppBar(
            actions: [
              if (user.value != null)
                SizedBox(
                  width: 150,
                  child: CheckboxListTile.adaptive(
                    value: !isFollowing,
                    onChanged: (value) =>
                        setState(() => isFollowing = !(value ?? false)),
                    title: const Text('Global'),
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: requireLogin(
              ref,
              'post an activity',
              () => showMarkdownEditor(
                context,
                onSave: (text) {
                  if (text.isNotEmpty) {
                    client.value.mutate$SaveTextActivity(
                      Options$Mutation$SaveTextActivity(
                        variables:
                            Variables$Mutation$SaveTextActivity(text: text),
                        onCompleted: (p0, p1) {
                          setState(() => isFollowing = true);
                          refetch!();
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            child: const Icon(Icons.edit),
          ),
          body: RefreshIndicator.adaptive(
            onRefresh: refetch!,
            child: Pagination(
              fetchMore: fetchMore!,
              pageInfo: result.parsedData!.Page!.pageInfo!,
              opts: FetchMoreOptions$Query$Activities(
                variables: Variables$Query$Activities(
                    page: result.parsedData!.Page!.pageInfo!.currentPage! + 1),
                updateQuery: (previousResultData, fetchMoreResultData) {
                  var has = <dynamic>{};

                  has.addAll(previousResultData!['Page']['activities']
                      .map((a) => a['id']));
                  // list.addAll(fetchMoreResultData!['Page']['activities']);

                  fetchMoreResultData!['Page']['activities']
                      .removeWhere((a) => has.contains(a['id']));

                  var list = [
                    ...previousResultData['Page']['activities'],
                    ...fetchMoreResultData['Page']['activities']
                  ];

                  fetchMoreResultData['Page']['activities'] = list;
                  return fetchMoreResultData;
                },
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var activity = result.parsedData!.Page!.activities![index]!;

                  if (activity
                      is Query$Activities$Page$activities$$TextActivity) {
                    return Comment(
                      avatarUrl: activity.user?.avatar?.large,
                      username: activity.user?.name,
                      createdAt: activity.createdAt,
                      onTap: () =>
                          context.pushRoute(ActivityRoute(id: activity.id)),
                      leading: Row(
                        children: [
                          IconButton(
                            onPressed: () => client.value.mutate$ToggleLike(
                              Options$Mutation$ToggleLike(
                                variables: Variables$Mutation$ToggleLike(
                                  id: activity.id,
                                  type: Enum$LikeableType.ACTIVITY,
                                ),
                              ),
                            ),
                            icon: Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: (activity.isLiked ?? false)
                                      ? Colors.red
                                      : null,
                                ),
                                if (activity.likeCount > 0)
                                  Text(activity.likeCount.toString()),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.forum,
                                color: Colors.grey[400],
                              ),
                              if (activity.replyCount > 0)
                                Text(activity.replyCount.toString()),
                            ],
                          ),
                        ],
                      ),
                      body: Markdown(
                        data: activity.text!,
                        selectable: false,
                      ),
                    );
                  } else if (activity
                      is Query$Activities$Page$activities$$ListActivity) {
                    return Comment(
                      avatarUrl: activity.user?.avatar?.large,
                      username: activity.user?.name,
                      createdAt: activity.createdAt,
                      onTap: () =>
                          context.pushRoute(ActivityRoute(id: activity.id)),
                      leading: Row(
                        children: [
                          IconButton(
                            onPressed: () => client.value.mutate$ToggleLike(
                              Options$Mutation$ToggleLike(
                                variables: Variables$Mutation$ToggleLike(
                                  id: activity.id,
                                  type: Enum$LikeableType.ACTIVITY,
                                ),
                              ),
                            ),
                            icon: Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: (activity.isLiked ?? false)
                                      ? Colors.red
                                      : null,
                                ),
                                if (activity.likeCount > 0)
                                  Text(activity.likeCount.toString()),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.forum,
                                color: Colors.grey[400],
                              ),
                              if (activity.replyCount > 0)
                                Text(activity.replyCount.toString()),
                            ],
                          ),
                        ],
                      ),
                      body: Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.router
                                .push(MediaRoute(id: activity.media!.id)),
                            child: ClipRRect(
                              borderRadius: imageRadius,
                              child: CImage(
                                imageUrl:
                                    activity.media!.coverImage!.extraLarge!,
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
                                    text: toBeginningOfSentenceCase(
                                        activity.status),
                                  ),
                                  if (activity.progress != null)
                                    TextSpan(text: ' ${activity.progress} of'),
                                  TextSpan(
                                    text:
                                        ' ${activity.media?.title?.userPreferred}',
                                    style: const TextStyle(
                                      color: linkColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => context.router.push(
                                            MediaRoute(id: activity.media!.id),
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
                  }

                  return const SizedBox();
                },
                itemCount: result.parsedData!.Page!.activities!.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
