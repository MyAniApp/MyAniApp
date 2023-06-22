import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/media/characters/characters.graphql.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/image.dart';
import 'package:myaniapp/ui/common/pagination.dart';

@RoutePage()
class MediaCharactersPage extends StatelessWidget {
  const MediaCharactersPage(
      {super.key, @PathParam.inherit('id') required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Query$Characters$Widget(
      options: Options$Query$Characters(
        variables: Variables$Query$Characters(mediaId: id),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading && result.parsedData == null) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (result.hasException) {
          return GraphqlError(exception: result.exception!);
        }

        return Pagination(
          pageInfo: result.parsedData!.Media!.characters!.pageInfo!,
          opts: FetchMoreOptions$Query$Characters(
            variables: Variables$Query$Characters(
                page: result
                        .parsedData!.Media!.characters!.pageInfo!.currentPage! +
                    1),
            updateQuery: (previousResultData, fetchMoreResultData) {
              var list = [
                ...previousResultData!['Media']!['characters']['edges'],
                ...fetchMoreResultData!['Media']!['characters']['edges'],
              ];
              fetchMoreResultData['Media']!['characters']['edges'] = list;
              return fetchMoreResultData;
            },
          ),
          fetchMore: fetchMore!,
          child: ListView.separated(
            padding: const EdgeInsets.all(5),
            itemCount: result.parsedData!.Media!.characters!.edges!.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemBuilder: (context, index) {
              var character =
                  result.parsedData!.Media!.characters!.edges![index]!;
              var voice = character.voiceActorRoles!.firstWhere(
                (element) => element?.voiceActor?.languageV2 == 'Japanese',
                orElse: () => null,
              );

              return Material(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    width: 1,
                  ),
                ),
                surfaceTintColor: Theme.of(context).colorScheme.surfaceVariant,
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 90,
                          child: AspectRatio(
                            aspectRatio: 2 / 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              child: CImage(
                                  imageUrl: character.node!.image!.large!),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.node!.name!.userPreferred!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (character.role != null)
                                Text(character.role!.name.capitalize())
                            ],
                          ),
                        )
                      ],
                    ),
                    if (voice != null)
                      Positioned(
                        right: 0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                voice.voiceActor?.name?.userPreferred ??
                                    'Unknown',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 90,
                              child: AspectRatio(
                                aspectRatio: 2 / 3,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: CImage(
                                    imageUrl: voice.voiceActor?.image?.large ??
                                        'https://s4.anilist.co/file/anilistcdn/staff/large/default.jpg',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
