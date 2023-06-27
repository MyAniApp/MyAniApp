import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/overview/overview.graphql.dart';
import 'package:myaniapp/providers/user/user.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/grid_cards.dart';
import 'package:myaniapp/ui/common/cards/sheet_card.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/routes/home/app_bar.dart';
import 'package:myaniapp/ui/routes/home/overview/guest.dart';
import 'package:myaniapp/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

@RoutePage()
class HomeOverviewPage extends ConsumerWidget {
  const HomeOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    if (user.value == null) return const Guest();

    return Scaffold(
      appBar: const HomeAppBar(),
      body: Query$Overview$Widget(
        options: Options$Query$Overview(
          variables: Variables$Query$Overview(
            userId: user.value!.id,
            type: Enum$MediaType.ANIME,
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

          return RefreshIndicator.adaptive(
            onRefresh: refetch!,
            child: ListView(
              children: [
                if (result.parsedData?.releasing?.media?.isNotEmpty == true)
                  _Releases(
                    releases: result.parsedData!.releasing!.media!.cast(),
                  ),
                if (result.parsedData?.list?.mediaList?.isNotEmpty == true)
                  _Watching(
                    entries: result.parsedData!.list!.mediaList!.cast(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Watching extends StatelessWidget {
  const _Watching({
    required this.entries,
  });

  final List<Fragment$MediaListEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Watching',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        GridCards(
          primary: false,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          card: (index) {
            var entry = entries[index];

            return GridCard(
              imageUrl: entry.media!.coverImage!.extraLarge!,
              title: entry.media!.title!.userPreferred,
              aspectRatio: 1.9 / 3,
              index: index,
              onTap: (index) => context.pushRoute(
                MediaRoute(id: entry.mediaId),
              ),
              onLongPress: (index) => showMediaCard(context, entry.media!),
            );
          },
          itemCount: entries.length,
        ),
      ],
    );
  }
}

class _Releases extends StatelessWidget {
  const _Releases({required this.releases});

  final List<Fragment$ReleasingMedia> releases;

  @override
  Widget build(BuildContext context) {
    var sorted = sortReleases(releases);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Releasing',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: 190,
          child: ListView.builder(
            padding: const EdgeInsets.only(right: 10),
            scrollDirection: Axis.horizontal,
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              var media = sorted[index];

              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GridCard(
                  imageUrl: media.coverImage!.extraLarge!,
                  title: media.title!.userPreferred,
                  index: media.id,
                  aspectRatio: 1.9 / 3,
                  onTap: (index) => context.pushRoute(
                    MediaRoute(id: media.id),
                  ),
                  onLongPress: (index) => showMediaCard(context, media),
                  chips: (index) {
                    var next = media.nextAiringEpisode;
                    var passed = media.airingSchedule?.edges
                        ?.firstWhere(
                          (a) => a?.node?.episode == next!.episode - 1,
                          orElse: () => null,
                        )
                        ?.node;
                    late dynamic use;
                    bool hasPassed = false;

                    if (isTodayFromTimestamp(passed?.airingAt) &&
                        hasTimestampPassed(passed?.airingAt)) {
                      use = passed;
                      hasPassed = true;
                    } else {
                      use = next;
                    }

                    return [
                      GridChip(
                        top: 2,
                        right: 2,
                        child: Text(
                          'Episode ${use.episode.toString()} ${hasPassed ? '(' : 'in '}${timeago.format(dateFromTimestamp(use.airingAt), allowFromNow: true)}${hasPassed ? ')' : ''}'
                              .replaceAll('from now', ''),
                        ),
                      ),
                    ];
                  },
                ),
              );
            },
            // // children: [
            // //   for (final media in sortReleases(releases))
            // //     Padding(
            // //       padding: const EdgeInsets.only(left: 10),
            // //       child: GridCard(
            // //         imageUrl: media.coverImage!.extraLarge!,
            // //         title: media.title!.userPreferred,
            // //         index: media.id,
            // //         aspectRatio: 1.9 / 3,
            // //         onTap: (index) => context.pushRoute(
            // //           MediaRoute(id: media.id),
            // //         ),
            // //         onLongPress: (index) => showMediaCard(context, media),
            // //         chips: (index) {
            // //           var next = media.nextAiringEpisode;
            // //           var passed = media.airingSchedule?.edges
            // //               ?.firstWhere(
            // //                 (a) => a?.node?.episode == next!.episode - 1,
            // //                 orElse: () => null,
            // //               )
            // //               ?.node;
            // //           late dynamic use;
            // //           bool hasPassed = false;

            // //           if (isTodayFromTimestamp(passed?.airingAt) &&
            // //               hasTimestampPassed(passed?.airingAt)) {
            // //             use = passed;
            // //             hasPassed = true;
            // //           } else {
            // //             use = next;
            // //           }

            // //           return [
            // //             GridChip(
            // //               top: 2,
            // //               right: 2,
            // //               child: Text(
            // //                 'Episode ${use.episode.toString()} ${hasPassed ? '(' : 'in '}${timeago.format(dateFromTimestamp(use.airingAt), allowFromNow: true)}${hasPassed ? ')' : ''}'
            // //                     .replaceAll('from now', ''),
            // //               ),
            // //             ),
            // //           ];
            // //         },
            // //       ),
            // //     ),
            // ],
          ),
        ),
      ],
    );
  }
}
