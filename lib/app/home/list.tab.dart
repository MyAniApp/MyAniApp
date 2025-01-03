import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp/app/home/screen.dart';
import 'package:myaniapp/common/media_list_view.dart';
import 'package:myaniapp/graphql/__gen/media_list.graphql.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/providers/settings.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:mygraphql/graphql.dart';

class HomeListTab extends StatefulHookConsumerWidget {
  const HomeListTab({super.key});

  @override
  ConsumerState<HomeListTab> createState() => _HomeListTabState();
}

class _HomeListTabState extends ConsumerState<HomeListTab> {
  late Enum$MediaType mediaType;

  @override
  void initState() {
    super.initState();
    mediaType =
        ref.read(settingsProvider.select((value) => value.defaultHomeList));
  }

  Icon getThumbIcon(Set<WidgetState> state) {
    if (state.contains(WidgetState.selected)) {
      return const Icon(Icons.tv);
    }

    return const Icon(Icons.book);
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    var (:snapshot, :fetchMore, :refetch) = c.useQuery(
      GQLRequest(
        mediaListQuery,
        variables: Variables$Query$MediaList(
          userName: user.value!.parsedData!.Viewer!.name,
          type: mediaType,
        ).toJson(),
        parseData: Query$MediaList.fromJson,
      ),
    );

    return RefreshIndicator.adaptive(
      notificationPredicate: (notification) => notification.depth == 1,
      onRefresh: refetch,
      child: MediaListView(
        response: snapshot,
        appBarLeading: const HomeLeadingIcon(),
        appBarActions: [
          Tooltip(
            message:
                "${mediaType == Enum$MediaType.ANIME ? "Anime" : "Manga"} List",
            child: Switch.adaptive(
              value: mediaType == Enum$MediaType.ANIME,
              onChanged: (value) => setState(() => mediaType =
                  mediaType == Enum$MediaType.ANIME
                      ? Enum$MediaType.MANGA
                      : Enum$MediaType.ANIME),
              thumbIcon: WidgetStateProperty.resolveWith(getThumbIcon),
            ),
          ),
        ],
        // groups: snapshot.parsedData!.MediaListCollection!.lists!
        //     .whereType<Fragment$ListGroup>()
        //     .toList(),
        // user: snapshot.parsedData!.MediaListCollection!.user!,
        type: mediaType,
        refetch: refetch,
      ),
    );
  }
}
