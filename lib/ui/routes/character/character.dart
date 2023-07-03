import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/character/character.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/media/media.graphql.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/grid_cards.dart';
import 'package:myaniapp/ui/common/cards/sheet_card.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/image.dart';
import 'package:myaniapp/ui/common/pagination.dart';
import 'package:myaniapp/ui/common/scroll_to_top.dart';
import 'package:myaniapp/ui/routes/media/overview.dart';

@RoutePage()
class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key, @PathParam('id') required this.id});

  final int id;

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  bool? onList;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Query$Character$Widget(
      options: Options$Query$Character(
        variables: Variables$Query$Character(id: widget.id, onList: onList),
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

        return ScrollToTop(
          builder: (scrollController) => Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: FloatingActionButton(
                      onPressed: result
                                  .parsedData!.Character!.isFavouriteBlocked ==
                              true
                          ? null
                          : () => client.value
                              .mutate$ToggleFavorite(
                                Options$Mutation$ToggleFavorite(
                                  variables: Variables$Mutation$ToggleFavorite(
                                    characterId:
                                        result.parsedData!.Character!.id,
                                  ),
                                ),
                              )
                              .then(
                                (value) => refetch!(),
                              ),
                      backgroundColor:
                          result.parsedData!.Character!.isFavouriteBlocked ==
                                  true
                              ? Colors.grey[800]
                              : Colors.red,
                      child: Icon(
                        Icons.favorite,
                        color: result.parsedData!.Character!.isFavourite == true
                            ? Colors.red[200]
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 65,
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 145,
                  pinned: true,
                  flexibleSpace: SafeArea(
                    child: FlexibleSpaceBar(
                      background: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 5),
                              child: SizedBox(
                                width: 90,
                                child: AspectRatio(
                                  aspectRatio: 2 / 3,
                                  child: ClipRRect(
                                    borderRadius: imageRadius,
                                    child: CImage(
                                      imageUrl: result
                                          .parsedData!.Character!.image!.large!,
                                      viewer: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Text(
                                    result.parsedData!.Character!.name!
                                        .userPreferred!,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (result.parsedData!.Character!
                                              .dateOfBirth !=
                                          null &&
                                      result.parsedData!.Character!.dateOfBirth!
                                              .toDateString() !=
                                          null)
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Birthday: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: result.parsedData!.Character!
                                                .dateOfBirth!
                                                .toDateString()!,
                                          )
                                        ],
                                      ),
                                    ),
                                  if (result.parsedData!.Character!.age != null)
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Age: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: result
                                                .parsedData!.Character!.age,
                                          )
                                        ],
                                      ),
                                    ),
                                  if (result.parsedData!.Character!.gender !=
                                      null)
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Gender: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: result
                                                .parsedData!.Character!.gender,
                                          )
                                        ],
                                      ),
                                    ),
                                  if (result.parsedData!.Character!.bloodType !=
                                      null)
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Blood Type: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: result.parsedData!.Character!
                                                .bloodType,
                                          )
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              body: Pagination(
                fetchMore: fetchMore!,
                pageInfo: result.parsedData!.Character!.media!.pageInfo!,
                isLoading: result.isLoading,
                opts: FetchMoreOptions$Query$Character(
                  variables: Variables$Query$Character(
                      page: result.parsedData!.Character!.media!.pageInfo!
                              .currentPage! +
                          1),
                  updateQuery: (previousResultData, fetchMoreResultData) {
                    var list = [
                      ...previousResultData!['Character']!['media']['edges'],
                      ...fetchMoreResultData!['Character']!['media']['edges'],
                    ];
                    fetchMoreResultData['Character']!['media']['edges'] = list;
                    return fetchMoreResultData;
                  },
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Description(
                            result.parsedData!.Character!.description),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Appearances',
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 140,
                              child: CheckboxListTile.adaptive(
                                title: const Text('On List'),
                                value: onList ?? false,
                                onChanged: (value) => setState(() =>
                                    onList = value == false ? null : true),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: GridCards(
                        primary: false,
                        padding: const EdgeInsets.all(8),
                        card: (index) {
                          var media = result
                              .parsedData!.Character!.media!.edges![index]!;

                          return GridCard(
                            imageUrl: media.node!.coverImage!.extraLarge!,
                            title: media.node!.title!.userPreferred,
                            aspectRatio: 1.9 / 3,
                            index: index,
                            onTap: (index) => context
                                .pushRoute(MediaRoute(id: media.node!.id)),
                            onLongPress: (index) =>
                                showMediaCard(context, media.node!),
                          );
                        },
                        itemCount:
                            result.parsedData!.Character!.media!.edges!.length,
                      ),
                    ),
                    if (result.isLoading)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
