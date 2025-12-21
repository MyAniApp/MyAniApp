import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/custom_dropdown.dart';
import 'package:myaniapp/common/ink_well_image.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/common/show.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/media_characters.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/common/gql_widget.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/routes.dart';
import 'package:mygraphql/graphql.dart';

class MediaCharactersTab extends HookWidget {
  const MediaCharactersTab({super.key, required this.mediaId});

  final int mediaId;

  @override
  Widget build(BuildContext context) {
    var (:snapshot, :fetchMore, :refetch) = gqlClient.useQuery(
      GQLRequest(
        mediaCharactersQuery,
        variables: Variables$Query$MediaCharacters(mediaId: mediaId).toJson(),
        parseData: Query$MediaCharacters.fromJson,
        mergeResults: defaultMergeResults("Media.characters.edges"),
      ),
    );
    var selectedLang = useState("Japanese");
    var availableLangs = useMemoized(() {
      var langs = [];
      if (snapshot.parsedData == null) return langs;
      snapshot
          .parsedData!
          .Media!
          .characters!
          .edges!
          .firstOrNull
          ?.voiceActorRoles
          ?.forEach((element) {
            var language =
                '${element!.voiceActor!.languageV2!}${element.dubGroup != null ? ' (${element.dubGroup})' : ''}';

            if (!langs.contains(language)) {
              langs.add(language);
            }
          });
      return langs;
    }, [snapshot.parsedData]);
    var charactersMemo =
        useMemoized<
          Iterable<
            ({
              Query$MediaCharacters$Media$characters$edges character,
              Query$MediaCharacters$Media$characters$edges$voiceActorRoles? va,
            })
          >
        >(() {
          if (snapshot.parsedData == null) return [];

          List<
            ({
              Query$MediaCharacters$Media$characters$edges character,
              Query$MediaCharacters$Media$characters$edges$voiceActorRoles? va,
            })
          >
          list = [];

          for (var c in snapshot.parsedData!.Media!.characters!.edges!) {
            var filtered = c!.voiceActorRoles?.where(
              (element) =>
                  '${element!.voiceActor!.languageV2!}${element.dubGroup != null ? ' (${element.dubGroup})' : ''}' ==
                  selectedLang.value,
            );
            if (filtered == null || filtered.isEmpty == true)
              list.add((character: c, va: null));

            for (var p in filtered!) list.add((character: c, va: p));
          }

          return list;
        }, [snapshot.parsedData, selectedLang.value]);

    return GQLWidget(
      refetch: refetch,
      response: snapshot,
      builder: () => Show(
        when: snapshot.parsedData!.Media!.characters!.edges!.isNotEmpty,
        fallback: Center(child: Text("No characters")),
        child: () => PaginationView.grid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 700,
            mainAxisExtent: 130,
          ),
          pageInfo: snapshot.parsedData!.Media!.characters!.pageInfo!,
          req: (nextPage) => fetchMore(
            variables: Variables$Query$MediaCharacters.fromJson(
              snapshot.request!.variables,
            ).copyWith(page: nextPage).toJson(),
          ),
          trailing: availableLangs.isNotEmpty
              ? SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: SliverToBoxAdapter(
                    child: SheetDropdownMenu<String>(
                      value: selectedLang.value,
                      onChanged: (values) => selectedLang.value = values.first,
                      items: availableLangs.map(
                        (e) => DropdownMenuEntry(
                          value: e,
                          label: e.toString().capitalize(),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
          itemCount: charactersMemo.length,
          itemBuilder: (context, index) {
            var (:character, :va) = charactersMemo.elementAt(index);

            return Card(
              child: InkWell(
                borderRadius: imageRadius,
                onTap: () => context.push(
                  Routes.character(character.node!.id),
                  extra: {"placeholder": character.node},
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: .start,
                        children: [
                          SizedBox(
                            height: double.maxFinite,
                            width: 90,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedImage(
                                character.node!.image!.large!,
                                fit: .cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(character.node!.name!.userPreferred!),
                                  if (character.role != null)
                                    Text(
                                      character.role!.name.capitalize(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelSmall,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (va != null)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: .end,
                          crossAxisAlignment: .start,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      va.voiceActor!.name!.userPreferred!,
                                      textAlign: .end,
                                    ),
                                    SizedBox(height: 10),
                                    if (va.roleNotes != null)
                                      Text(
                                        '(${va.roleNotes!})',
                                        textAlign: .end,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            InkWellImage(
                              onTap: () => context.push(
                                Routes.staff(va.voiceActor!.id),
                                extra: {"placeholder": va.voiceActor},
                              ),
                              child: SizedBox(
                                height: double.maxFinite,
                                width: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedImage(
                                    va.voiceActor!.image!.large!,
                                    fit: .cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
