import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/pages/home/animelist/animelist.graphql.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:myaniapp/ui/common/graphql.dart';
import 'package:myaniapp/ui/common/media_list_group.dart';
import 'package:myaniapp/ui/pages/home/app_bar.dart';

@RoutePage()
class AnimeListPage extends HookConsumerWidget {
  const AnimeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    var hook = useQuery$MediaList(
      Options$Query$MediaList(
        variables: Variables$Query$MediaList(
          userId: user.value!.id,
          type: Enum$MediaType.ANIME,
          sort: [
            Enum$MediaListSort.STATUS,
            Enum$MediaListSort.UPDATED_TIME_DESC
          ],
        ),
      ),
    );

    return RefreshIndicator(
      onRefresh: hook.refetch,
      notificationPredicate: (notification) => notification.depth == 1,
      child: Graphql(
        hook: hook,
        builder: (result) {
          var groups = MediaListGroups(
            groups: result.MediaListCollection!.lists!
                .whereType<Fragment$ListGroup>()
                .toList(),
            isEditable: true,
            onSave: hook.refetch,
          );

          return DefaultTabController(
            length: groups.groups.length,
            child: Scaffold(
              appBar: Appbar(
                bottom: groups.tabBar,
              ),
              body: groups.tabView,
            ),
          );
        },
      ),
    );
  }
}
