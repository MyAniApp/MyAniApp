import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/home.graphql.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/grid_cards.dart';
import 'package:myaniapp/ui/common/cards/sheet_card.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';

@RoutePage()
class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Query$Browsing$Widget(
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (result.hasException) {
          return GraphqlError(exception: result.exception!);
        }

        return RefreshIndicator.adaptive(
          onRefresh: () => refetch?.call().then((value) {}) ?? Future.value(),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => context.pushRoute(SearchRoute(autofocus: true)),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: theme.hintColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Text(
                            'Search...',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FilterChip(
                    label: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.thumb_up,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Recommendations'),
                      ],
                    ),
                    onSelected: (value) => context.pushRoute(
                      const RecommendationsRoute(),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      'Trending',
                      style: theme.textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () => context.pushRoute(
                        SearchRoute(
                          sort: Enum$MediaSort.TRENDING_DESC.name,
                        ),
                      ),
                      child: const Text('View More'),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                child: _List(
                  medias: result.parsedData!.trending!.media!.cast(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      'All Time Popular',
                      style: theme.textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () => context.pushRoute(
                        SearchRoute(
                          sort: Enum$MediaSort.POPULARITY_DESC.name,
                        ),
                      ),
                      child: const Text('View More'),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                child: _List(
                  medias: result.parsedData!.popular!.media!.cast(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      'Recently Added',
                      style: theme.textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () => context.pushRoute(
                        SearchRoute(
                          sort: Enum$MediaSort.ID_DESC.name,
                        ),
                      ),
                      child: const Text('View More'),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                child: _List(
                  medias: result.parsedData!.recent!.media!.cast(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.medias});

  final List<Fragment$MediaFragment> medias;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(right: 10),
      scrollDirection: Axis.horizontal,
      // shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        var media = medias[index];

        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GridCard(
            imageUrl: media.coverImage!.extraLarge!,
            title: media.title!.userPreferred,
            aspectRatio: 1.9 / 3,
            index: index,
            onTap: (index) => context.pushRoute(MediaRoute(id: media.id)),
            onLongPress: (index) => showMediaCard(context, media),
          ),
        );
      },
    );
  }
}
