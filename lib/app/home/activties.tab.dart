import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useState;
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp/app/home/screen.dart';
import 'package:myaniapp/common/activity_card.dart';
import 'package:myaniapp/common/hiding_floating_button.dart';
import 'package:myaniapp/common/markdown_editor.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/graphql/__gen/home_activities.graphql.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/mutations.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/common/gql_widget.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:myaniapp/utils.dart';
import 'package:mygraphql/graphql.dart';

enum ActivityFilter { all, text, list }

class HomeActivitiesTab extends HookConsumerWidget {
  const HomeActivitiesTab({super.key});

  Icon getThumbIcon(Set<WidgetState> state) {
    if (state.contains(WidgetState.selected)) {
      return const Icon(Icons.people);
    }

    return const Icon(Icons.public);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFollowing = useState(false);
    final activityFilter = useState(ActivityFilter.all);

    var user = ref.watch(userProvider);
    var (:snapshot, :fetchMore, :refetch) = gqlClient.useQuery(
      GQLRequest(
        homeActivitiesQuery,
        variables: Variables$Query$HomeActivities(
          hasReplies: !isFollowing.value,
          isFollowing: isFollowing.value,
          activityType: activityFilter.value == .all
              ? null
              : activityFilter.value == .list
              ? .MEDIA_LIST
              : activityFilter.value == .text
              ? .TEXT
              : null,
        ).toJson(),
        parseData: (json) {
          var list = Query$HomeActivities.fromJson(json);
          if (hideAdultContent ||
              user.value?.parsedData?.Viewer?.options?.displayAdultActivities ==
                  false) {
            return list.copyWith(
              Page: list.Page?.copyWith(
                activities: [
                  ...?list.Page?.activities?.whereNot((m) {
                    return m?.when(
                          textActivity: (t) => false,
                          listActivity: (l) => l.media?.isAdult == true,
                          messageActivity: (m) => false,
                          orElse: () => false,
                        ) ==
                        true;
                  }),
                ],
              ),
            );
          }
          return list;
        },
        mergeResults: defaultMergeResults("Page.activities"),
      ),
    );

    return HidingFloatingButton(
      button: FloatingActionButton(
        onPressed: requiredLogin(
          ref,
          "send a post",
          () => MarkdownEditor.show(
            context,
            onSave: (text) => mutationSaveTextActivity(text).then((value) {
              if (!isFollowing.value) {
                isFollowing.value = true;
              } else {
                refetch();
              }
            }),
            hint: "Write a post",
          ),
        ),
        child: const Icon(Icons.post_add),
      ),
      builder: (button) => Scaffold(
        appBar: AppBar(
          leading: const HomeLeadingIcon(),
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                showDragHandle: true,
                enableDrag: true,
                builder: (context) => RadioGroup<ActivityFilter>(
                  groupValue: activityFilter.value,
                  onChanged: (value) {
                    activityFilter.value = value ?? .all;
                    context.pop();
                  },
                  child: ListView(
                    children: [
                      RadioListTile<ActivityFilter>.adaptive(
                        title: Text("All"),
                        value: .all,
                      ),
                      RadioListTile<ActivityFilter>.adaptive(
                        title: Text("Text"),
                        value: .text,
                      ),
                      RadioListTile<ActivityFilter>.adaptive(
                        title: Text("List Progress"),
                        value: .list,
                      ),
                    ],
                  ),
                ),
              ),
              icon: Icon(Icons.filter_alt_outlined),
            ),
            if (user.value?.data != null)
              Switch.adaptive(
                value: isFollowing.value,
                thumbIcon: WidgetStateProperty.resolveWith(getThumbIcon),
                onChanged: (value) {
                  isFollowing.value = !isFollowing.value;
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () => refetch(),
                  );
                },
              ),
          ],
        ),
        floatingActionButton: button,
        body: GQLWidget(
          response: snapshot,
          refetch: refetch,
          builder: () => RefreshIndicator.adaptive(
            onRefresh: refetch,
            child: PaginationView.list(
              req: (nextPage) => fetchMore(
                variables: Variables$Query$HomeActivities.fromJson(
                  snapshot.request!.variables,
                ).copyWith(page: nextPage).toJson(),
              ),
              pageInfo: snapshot.parsedData!.Page!.pageInfo!,
              itemBuilder: (context, index) {
                var activity = snapshot.parsedData!.Page!.activities![index]!;

                return ActivityCard(activity: activity, refetch: refetch);
              },
              itemCount: snapshot.parsedData!.Page!.activities!.length,
            ),
          ),
        ),
      ),
    );
  }
}
