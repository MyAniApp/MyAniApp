import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/list/list.graphql.dart';
import 'package:myaniapp/providers/user/user.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/grid_cards.dart';
import 'package:myaniapp/ui/common/cards/sheet_card.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/media_editor/media_editor.dart';
import 'package:myaniapp/ui/routes/home/app_bar.dart';

@RoutePage()
class HomeAnimePage extends ConsumerWidget {
  const HomeAnimePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    return Query$MediaList$Widget(
      options: Options$Query$MediaList(
        cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
        variables: Variables$Query$MediaList(
          sort: [
            Enum$MediaListSort.STATUS,
            Enum$MediaListSort.UPDATED_TIME_DESC,
          ],
          type: Enum$MediaType.ANIME,
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

class Media extends StatefulWidget {
  const Media({
    super.key,
    required this.list,
  });

  final Fragment$ListGroup list;

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return GridCards(
      // primary: false,
      padding: const EdgeInsets.all(8),
      card: (index) {
        var media = widget.list.entries![index]!;

        return GridCard(
          imageUrl: media.media!.coverImage!.extraLarge!,
          title: media.media!.title!.userPreferred,
          aspectRatio: 1.9 / 3,
          index: index,
          onTap: (index) => context.pushRoute(MediaRoute(id: media.mediaId)),
          onLongPress: (index) => showMediaCard(context, media.media!),
          onDoubleTap: (index) => showMediaEditor(context, media.media!),
        );
      },
      itemCount: widget.list.entries!.length,
    );
  }
}