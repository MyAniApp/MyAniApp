import 'package:collection/collection.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/__gen/search_media.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/main.dart';
import 'package:mygraphql/graphql.dart';

class MediaSearchQuery {
  MediaSearchQuery(
    this.rawQuery, {
    this.withTags,
    this.withoutTags,
    this.search,
    this.sort,
    this.type,
    this.format,
    this.genres,
    this.season,
    // this.seasonYear,
    this.year,
    this.startDate,
    this.endDate,
    this.isAdult,
    this.onList,
    this.countryOfOrigin,
  });

  String? search;
  List<Enum$MediaSort>? sort;
  Enum$MediaType? type;
  List<Enum$MediaFormat>? format;
  List<String>? genres;
  List<Query$GenreCollection$tags>? withTags;
  List<Query$GenreCollection$tags>? withoutTags;
  Enum$MediaSeason? season;
  // int? seasonYear;
  int? year;
  // yearGreater
  int? startDate;
  // yearLesser
  int? endDate;
  bool? isAdult;
  bool? onList;
  String? countryOfOrigin;
  final Map<String, dynamic> rawQuery;

  bool get isEmpty => toString() == "?";

  static Future<MediaSearchQuery> from(Map<String, dynamic> query) async {
    List<Enum$MediaSort>? sort0;
    List<Enum$MediaFormat>? format0;
    List<String>? genre0;
    List<Query$GenreCollection$tags>? withTag0;
    List<Query$GenreCollection$tags>? withoutTag0;
    Enum$MediaType? type0 = Enum$MediaType.values
        .firstWhereOrNull((element) => element.name == query["type"]?.first);
    Enum$MediaSeason? season0 = Enum$MediaSeason.values
        .firstWhereOrNull((element) => element.name == query["season"]?.first);

    Query$GenreCollection? collection;

    if (query["withTags"] != null ||
        query["withoutTags"] != null ||
        query["genre"] != null) {
      collection = (await c
              .query(GQLRequest(genreCollectionQuery,
                  fetchPolicy: FetchPolicy.cacheFirst,
                  parseData: Query$GenreCollection.fromJson))
              .last)
          .parsedData;
    }

    if (query["sort"] != null) {
      var s = Enum$MediaSort.values
          .where((element) => query["sort"].contains(element.name));
      if (s.isNotEmpty) {
        sort0 = s.toList();
      }
    }

    if (query["genre"] != null) {
      var g = collection!.genres!
          .where((element) => query["genre"].contains(element));
      if (g.isNotEmpty) {
        genre0 = g.cast<String>().toList();
      }
    }

    if (query["withTags"] != null) {
      var t = collection!.tags!
          .where((element) => query["withTags"].contains(element!.name));
      if (t.isNotEmpty) {
        withTag0 = t.cast<Query$GenreCollection$tags>().toList();
      }
    }

    if (query["withoutTags"] != null) {
      var t = collection!.tags!
          .where((element) => query["withoutTags"].contains(element!.name));
      if (t.isNotEmpty == true) {
        withoutTag0 = t.cast<Query$GenreCollection$tags>().toList();
      }
    }

    if (query["format"] != null) {
      var f = Enum$MediaFormat.values
          .where((element) => query["format"].contains(element.name));
      if (f.isNotEmpty) {
        format0 = f.toList();
      }
    }
    // print(query);
    return MediaSearchQuery(
      query,
      search: query["search"]?[0],
      sort: sort0,
      type: type0,
      format: format0,
      genres: genre0,
      withTags: withTag0,
      withoutTags: withoutTag0,
      season: season0,
      countryOfOrigin: query["countryOfOrigin"]?.first,
      endDate: query["endDate"]?.first != null
          ? int.tryParse(query["endDate"]?.first)
          : null,
      isAdult: query["isAdult"]?.first != null
          ? bool.tryParse(query["isAdult"]?.first)
          : null,
      onList: query["onList"]?.first != null
          ? bool.tryParse(query["onList"]?.first)
          : null,
      startDate: query["startDate"]?.first != null
          ? int.tryParse(query["startDate"]?.first)
          : null,
      year: query["year"]?.first != null
          ? int.tryParse(query["year"]?.first)
          : null,
    );
  }

  GQLRequest<Query$Search> toReq() {
    return GQLRequest(
      searchQuery,
      parseData: Query$Search.fromJson,
      mergeResults: defaultMergeResults("Page.media"),
      variables: _removeNulls(Variables$Query$Search(
        format: format,
        sort: sort,
        countryOfOrigin: countryOfOrigin,
        genres: genres,
        isAdult: isAdult,
        onList: onList,
        search: search,
        season: season,
        seasonYear: (year != null && season != null) ? year : null,
        type: type,
        with_tags: withTags
            ?.map(
              (e) => e.name,
            )
            .toList(),
        without_tags: withoutTags
            ?.map(
              (e) => e.name,
            )
            .toList(),
        year: (year != null && season == null) ? "$year%" : null,
        yearGreater: endDate.toString(),
        yearLesser: startDate.toString(),
      )).toJson(),
    );
  }

  Variables$Query$Search _removeNulls(Variables$Query$Search vars) {
    return Variables$Query$Search.fromJson(
        vars.toJson()..removeWhere((key, value) => value == 'null'));
  }

  @override
  String toString() {
    List<String> query = [];

    query.addAll([
      if (search != null) 'search=$search',
      if (sort?.isNotEmpty == true)
        sort!.map((e) => 'sort=${e.name}').join('&'),
      if (type != null) 'type=${type!.name}',
      if (format?.isNotEmpty == true)
        format!.map((e) => 'format=${e.name}').join('&'),
      if (genres?.isNotEmpty == true) genres!.map((e) => 'genre=$e').join('&'),
      if (season != null) 'season=${season!.name}',
      if (endDate != null) 'endDate=$endDate',
      if (startDate != null) 'startDate=$startDate',
      if (isAdult != null) 'isAdult=$isAdult',
      if (onList != null) 'onList=$onList',
      if (year != null) 'year=$year',
      if (withTags?.isNotEmpty == true)
        withTags!.map((e) => 'withTags=${e.name}').join('&'),
      if (withoutTags?.isNotEmpty == true)
        withoutTags!.map((e) => 'withoutTags=${e.name}').join('&'),
      if (countryOfOrigin != null) 'countryOfOrigin=$countryOfOrigin',
    ]);

    return '?${query.join('&')}';
  }
}
