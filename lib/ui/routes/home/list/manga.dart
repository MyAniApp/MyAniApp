import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/list/list.graphql.dart';
import 'package:myaniapp/providers/user/user.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/routes/home/app_bar.dart';
import 'package:myaniapp/ui/routes/home/list/anime.dart';

@RoutePage()
class HomeMangaPage extends ConsumerWidget {
  const HomeMangaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    return Query$MediaList$Widget(
      options: Options$Query$MediaList(
        variables: Variables$Query$MediaList(
          sort: [
            Enum$MediaListSort.STATUS,
            Enum$MediaListSort.UPDATED_TIME_DESC,
          ],
          type: Enum$MediaType.MANGA,
          userId: user.value!.id,
        ),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (result.hasException) {
          return GraphqlError(exception: result.exception!);
        }

        var lists = result.parsedData!.MediaListCollection!.lists!;

        return DefaultTabController(
          length: lists.length,
          child: Scaffold(
            appBar: HomeAppBar(
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
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
