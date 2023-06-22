import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/home/home.graphql.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/sheet_card.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/image.dart';

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
              ElevatedButton(
                onPressed: () => context.pushRoute(
                  SearchRoute(),
                ),
                child: const Text('Search'),
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
                height: 230,
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
                height: 230,
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
                height: 230,
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
      padding: const EdgeInsets.only(top: 10, right: 10),
      scrollDirection: Axis.horizontal,
      // shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        var media = medias[index];

        return SizedBox(
          // height: imageHeight + 30,
          width: 140,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () => context.pushRoute(MediaRoute(id: media.id)),
              onLongPress: () => showMediaCard(context, media),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: imageRadius,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: CImage(
                        imageUrl: media.coverImage!.extraLarge!,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      media.title!.userPreferred!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}