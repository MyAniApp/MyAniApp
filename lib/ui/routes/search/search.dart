import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/search/search.graphql.dart';
import 'package:myaniapp/providers/search.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/cards/grid_cards.dart';
import 'package:myaniapp/ui/common/cards/sheet_card.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/routes/search/editor/editor.dart';

@RoutePage()
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({
    super.key,
    @QueryParam('sort') this.sort = '',
    @QueryParam('search') this.search,
    @queryParam this.type,
    @QueryParam('genre') this.genre = '',
    @QueryParam('tag') this.tag = '',
    this.autofocus,
  });

  final dynamic sort;
  final dynamic genre;
  final dynamic tag;
  final String? search;
  final String? type;
  final bool? autofocus;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      bool setVars = false;

      if (widget.sort != '' ||
          widget.genre != '' ||
          widget.tag != '' ||
          widget.search != null ||
          widget.type != null) {
        ref
            .read(searchProvider.notifier)
            .setVariables(Variables$Query$Search(), fetch: false);
        setVars = true;
      }

      if (widget.sort != '') {
        switch (widget.sort.runtimeType) {
          case (String):
            var sort = Enum$MediaSort.values
                .where((element) => element.name == widget.sort);
            if (sort.isNotEmpty) {
              ref.read(searchProvider.notifier).setVariables(
                    ref
                        .read(searchProvider.notifier)
                        .variables!
                        .copyWith(sort: sort.toList()),
                    fetch: false,
                  );
            }
            break;
          case const (List<String>):
            var sort = Enum$MediaSort.values
                .where((element) => widget.sort.contains(element.name));
            if (sort.isNotEmpty) {
              ref.read(searchProvider.notifier).setVariables(
                    ref
                        .read(searchProvider.notifier)
                        .variables!
                        .copyWith(sort: sort.toList()),
                    fetch: false,
                  );
            }
            break;
        }
      }

      if (widget.genre != '') {
        var genres = (
          await client.value.query$GenreCollection(
            Options$Query$GenreCollection(
              fetchPolicy: FetchPolicy.cacheFirst,
            ),
          ),
        ).$1.parsedData!.genres!;

        switch (widget.genre.runtimeType) {
          case (String):
            var genre = genres.where((element) => element == widget.genre);
            if (genre.isNotEmpty) {
              ref.read(searchProvider.notifier).setVariables(
                    ref
                        .read(searchProvider.notifier)
                        .variables!
                        .copyWith(genres: genre.toList()),
                    fetch: false,
                  );
            }
            break;
          case const (List<String>):
            var genre =
                genres.where((element) => widget.genre.contains(element));
            if (genre.isNotEmpty) {
              ref.read(searchProvider.notifier).setVariables(
                  ref
                      .read(searchProvider.notifier)
                      .variables!
                      .copyWith(genres: genre.toList()),
                  fetch: false);
            }
            break;
        }
      }

      if (widget.tag != '') {
        var tags = (
          await client.value.query$GenreCollection(
            Options$Query$GenreCollection(
              fetchPolicy: FetchPolicy.cacheFirst,
            ),
          ),
        ).$1.parsedData!.tags!;

        switch (widget.tag.runtimeType) {
          case (String):
            var tag = tags
                .where((element) => element!.name == widget.tag)
                .map((e) => e!.name);
            if (tag.isNotEmpty) {
              ref.read(searchProvider.notifier).setVariables(
                    ref
                        .read(searchProvider.notifier)
                        .variables!
                        .copyWith(with_tags: tag.toList()),
                    fetch: false,
                  );
            }
            break;
          case const (List<String>):
            var tag = tags
                .where((element) => widget.tag.contains(element))
                .map((e) => e!.name);
            if (tag.isNotEmpty) {
              ref.read(searchProvider.notifier).setVariables(
                  ref
                      .read(searchProvider.notifier)
                      .variables!
                      .copyWith(with_tags: tag.toList()),
                  fetch: false);
            }
            break;
        }
      }

      if (widget.search != null) {
        ref.read(searchProvider.notifier).setVariables(
              ref
                  .read(searchProvider.notifier)
                  .variables!
                  .copyWith(search: widget.search),
              fetch: false,
            );
      }

      if (widget.type != null) {
        Enum$MediaType type = Enum$MediaType.values.firstWhere(
          (element) => element.name == widget.type,
          orElse: () => Enum$MediaType.$unknown,
        );

        if (type != Enum$MediaType.$unknown) {
          ref.read(searchProvider.notifier).setVariables(
                ref
                    .read(searchProvider.notifier)
                    .variables!
                    .copyWith(type: type),
                fetch: false,
              );
        }
      }

      if (setVars) {
        ref
            .read(searchProvider.notifier)
            .setVariables(ref.read(searchProvider.notifier).variables!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var search = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        flexibleSpace: FlexibleSpaceBar(
          background: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                onSubmitted: (value) =>
                    ref.read(searchProvider.notifier).setVariables(
                          (ref.read(searchProvider.notifier).variables ??
                                  Variables$Query$Search())
                              .copyWith(search: value),
                        ),
                focusNode: FocusNode(canRequestFocus: false),
                autofocus: widget.autofocus ?? false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: AutoLeadingButton(),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () => showSearchEditor(context),
                      icon: const Icon(Icons.more_horiz),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: search.when(
        data: (data) {
          if (data.Page?.media?.isEmpty == true) {
            return Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Results',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            );
          }

          return NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >
                      notification.metrics.maxScrollExtent - 100 &&
                  data.Page!.pageInfo!.hasNextPage == true) {
                ref.read(searchProvider.notifier).nextPage();
              }
              return false;
            },
            child: GridCards(
              padding: const EdgeInsets.all(8),
              card: (index) {
                var media = data.Page!.media![index]!;

                return GridCard(
                  imageUrl: media.coverImage!.extraLarge!,
                  aspectRatio: 1.9 / 3,
                  index: index,
                  underTitle: (index, style) =>
                      Text(media.title!.userPreferred!),
                  onTap: (index) => context.pushRoute(MediaRoute(id: media.id)),
                  onLongPress: (index) => showMediaCard(context, media),
                );
              },
              itemCount: data.Page!.media!.length,
            ),
          );
        },
        error: (error, stackTrace) =>
            GraphqlError(exception: error as OperationException),
        loading: () => ref.read(searchProvider.notifier).variables != null
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : const SizedBox(),
      ),
    );
  }
}
