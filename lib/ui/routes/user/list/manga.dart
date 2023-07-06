import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/list/list.graphql.dart';
import 'package:myaniapp/providers/settings.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/routes/home/list/anime.dart';

@RoutePage()
class UserMangaListPage extends StatelessWidget {
  const UserMangaListPage({super.key, @PathParam('name') required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Query$MediaList$Widget(
      options: Options$Query$MediaList(
        variables: Variables$Query$MediaList(
          sort: [
            Enum$MediaListSort.STATUS,
            Enum$MediaListSort.UPDATED_TIME_DESC,
          ],
          type: Enum$MediaType.MANGA,
          userName: name,
        ),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading && result.data == null) {
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

        var lists = result.parsedData!.MediaListCollection!.lists!;

        return RefreshIndicator.adaptive(
          onRefresh: refetch!,
          notificationPredicate: (notification) => notification.depth == 1,
          child: DefaultTabController(
            length: lists.length,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  isScrollable: true,
                  tabs: lists
                      .map(
                        (e) => Tab(
                          text: '${e!.name} (${e.entries!.length})',
                        ),
                      )
                      .toList(),
                ),
              ),
              body: TabBarView(
                children: lists
                    .map(
                      (list) => Media(
                        list: list!,
                        refresh: refetch,
                        canEdit: false,
                        setting: Setting.mangaList,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
