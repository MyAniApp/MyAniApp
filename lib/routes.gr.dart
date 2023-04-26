// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:flutter/material.dart' as _i26;
import 'package:myaniapp/ui/empty_route.dart' as _i1;
import 'package:myaniapp/ui/pages/activity/activity.dart' as _i2;
import 'package:myaniapp/ui/pages/character/character.dart' as _i3;
import 'package:myaniapp/ui/pages/home/animelist/animelist.dart' as _i4;
import 'package:myaniapp/ui/pages/home/discover/discover.dart' as _i5;
import 'package:myaniapp/ui/pages/home/home.dart' as _i6;
import 'package:myaniapp/ui/pages/home/mangalist/mangalist.dart' as _i7;
import 'package:myaniapp/ui/pages/home/overview/overview.dart' as _i8;
import 'package:myaniapp/ui/pages/home/social/social.dart' as _i9;
import 'package:myaniapp/ui/pages/login/anilist.dart' as _i10;
import 'package:myaniapp/ui/pages/login/login.dart' as _i11;
import 'package:myaniapp/ui/pages/login/token.dart' as _i12;
import 'package:myaniapp/ui/pages/media/media.dart' as _i13;
import 'package:myaniapp/ui/pages/profile/lists/anime.dart' as _i14;
import 'package:myaniapp/ui/pages/profile/lists/manga.dart' as _i15;
import 'package:myaniapp/ui/pages/profile/profile.dart' as _i16;
import 'package:myaniapp/ui/pages/review/review.dart' as _i17;
import 'package:myaniapp/ui/pages/search/search.dart' as _i18;
import 'package:myaniapp/ui/pages/settings/app.dart' as _i19;
import 'package:myaniapp/ui/pages/settings/colors.dart' as _i20;
import 'package:myaniapp/ui/pages/settings/settings.dart' as _i21;
import 'package:myaniapp/ui/pages/staff/staff.dart' as _i22;
import 'package:myaniapp/ui/pages/thread/thread.dart' as _i23;
import 'package:myaniapp/ui/pages/threads/threads.dart' as _i24;

abstract class $Router extends _i25.RootStackRouter {
  $Router({super.navigatorKey});

  @override
  final Map<String, _i25.PageFactory> pagesMap = {
    EmptyRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.EmptyPage(),
      );
    },
    ActivityRoute.name: (routeData) {
      final args = routeData.argsAs<ActivityRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ActivityPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    CharacterRoute.name: (routeData) {
      final args = routeData.argsAs<CharacterRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CharacterPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    AnimeListRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AnimeListPage(),
      );
    },
    DiscoverRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DiscoverPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomePage(),
      );
    },
    MangaListRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MangaListPage(),
      );
    },
    OverviewRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.OverviewPage(),
      );
    },
    SocialRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SocialPage(),
      );
    },
    AniLoginRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.AniLoginPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.LoginPage(),
      );
    },
    TokenLoginRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.TokenLoginPage(),
      );
    },
    MediaRoute.name: (routeData) {
      final args = routeData.argsAs<MediaRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.MediaPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    ProfileAnimeListRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileAnimeListRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.ProfileAnimeListPage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    ProfileMangaListRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileMangaListRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.ProfileMangaListPage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.ProfilePage(
          key: args.key,
          name: args.name,
        ),
      );
    },
    Review.name: (routeData) {
      final args = routeData.argsAs<ReviewArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.Review(
          key: args.key,
          id: args.id,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      final args = routeData.argsAs<SearchRouteArgs>(
          orElse: () => const SearchRouteArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.SearchPage(
          key: args.key,
          isAdult: args.isAdult,
          type: args.type,
          sort: args.sort,
          year: args.year,
          season: args.season,
          search: args.search,
          genres: args.genres,
          hideOnList: args.hideOnList,
          tags: args.tags,
        ),
      );
    },
    AppSettingsRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.AppSettingsPage(),
      );
    },
    ColorsRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.ColorsPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.SettingsPage(),
      );
    },
    StaffRoute.name: (routeData) {
      final args = routeData.argsAs<StaffRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.StaffPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    ThreadRoute.name: (routeData) {
      final args = routeData.argsAs<ThreadRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.ThreadPage(
          args.id,
          key: args.key,
        ),
      );
    },
    ThreadsRoute.name: (routeData) {
      final args = routeData.argsAs<ThreadsRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.ThreadsPage(
          key: args.key,
          feed: args.feed,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.EmptyPage]
class EmptyRoute extends _i25.PageRouteInfo<void> {
  const EmptyRoute({List<_i25.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ActivityPage]
class ActivityRoute extends _i25.PageRouteInfo<ActivityRouteArgs> {
  ActivityRoute({
    _i26.Key? key,
    required int id,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          ActivityRoute.name,
          args: ActivityRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'ActivityRoute';

  static const _i25.PageInfo<ActivityRouteArgs> page =
      _i25.PageInfo<ActivityRouteArgs>(name);
}

class ActivityRouteArgs {
  const ActivityRouteArgs({
    this.key,
    required this.id,
  });

  final _i26.Key? key;

  final int id;

  @override
  String toString() {
    return 'ActivityRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i3.CharacterPage]
class CharacterRoute extends _i25.PageRouteInfo<CharacterRouteArgs> {
  CharacterRoute({
    _i26.Key? key,
    required int id,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          CharacterRoute.name,
          args: CharacterRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'CharacterRoute';

  static const _i25.PageInfo<CharacterRouteArgs> page =
      _i25.PageInfo<CharacterRouteArgs>(name);
}

class CharacterRouteArgs {
  const CharacterRouteArgs({
    this.key,
    required this.id,
  });

  final _i26.Key? key;

  final int id;

  @override
  String toString() {
    return 'CharacterRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i4.AnimeListPage]
class AnimeListRoute extends _i25.PageRouteInfo<void> {
  const AnimeListRoute({List<_i25.PageRouteInfo>? children})
      : super(
          AnimeListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnimeListRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DiscoverPage]
class DiscoverRoute extends _i25.PageRouteInfo<void> {
  const DiscoverRoute({List<_i25.PageRouteInfo>? children})
      : super(
          DiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i25.PageRouteInfo<void> {
  const HomeRoute({List<_i25.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MangaListPage]
class MangaListRoute extends _i25.PageRouteInfo<void> {
  const MangaListRoute({List<_i25.PageRouteInfo>? children})
      : super(
          MangaListRoute.name,
          initialChildren: children,
        );

  static const String name = 'MangaListRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i8.OverviewPage]
class OverviewRoute extends _i25.PageRouteInfo<void> {
  const OverviewRoute({List<_i25.PageRouteInfo>? children})
      : super(
          OverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OverviewRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SocialPage]
class SocialRoute extends _i25.PageRouteInfo<void> {
  const SocialRoute({List<_i25.PageRouteInfo>? children})
      : super(
          SocialRoute.name,
          initialChildren: children,
        );

  static const String name = 'SocialRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i10.AniLoginPage]
class AniLoginRoute extends _i25.PageRouteInfo<void> {
  const AniLoginRoute({List<_i25.PageRouteInfo>? children})
      : super(
          AniLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'AniLoginRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i11.LoginPage]
class LoginRoute extends _i25.PageRouteInfo<void> {
  const LoginRoute({List<_i25.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i12.TokenLoginPage]
class TokenLoginRoute extends _i25.PageRouteInfo<void> {
  const TokenLoginRoute({List<_i25.PageRouteInfo>? children})
      : super(
          TokenLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'TokenLoginRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i13.MediaPage]
class MediaRoute extends _i25.PageRouteInfo<MediaRouteArgs> {
  MediaRoute({
    _i26.Key? key,
    required int id,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          MediaRoute.name,
          args: MediaRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'MediaRoute';

  static const _i25.PageInfo<MediaRouteArgs> page =
      _i25.PageInfo<MediaRouteArgs>(name);
}

class MediaRouteArgs {
  const MediaRouteArgs({
    this.key,
    required this.id,
  });

  final _i26.Key? key;

  final int id;

  @override
  String toString() {
    return 'MediaRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i14.ProfileAnimeListPage]
class ProfileAnimeListRoute
    extends _i25.PageRouteInfo<ProfileAnimeListRouteArgs> {
  ProfileAnimeListRoute({
    _i26.Key? key,
    required int userId,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          ProfileAnimeListRoute.name,
          args: ProfileAnimeListRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileAnimeListRoute';

  static const _i25.PageInfo<ProfileAnimeListRouteArgs> page =
      _i25.PageInfo<ProfileAnimeListRouteArgs>(name);
}

class ProfileAnimeListRouteArgs {
  const ProfileAnimeListRouteArgs({
    this.key,
    required this.userId,
  });

  final _i26.Key? key;

  final int userId;

  @override
  String toString() {
    return 'ProfileAnimeListRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i15.ProfileMangaListPage]
class ProfileMangaListRoute
    extends _i25.PageRouteInfo<ProfileMangaListRouteArgs> {
  ProfileMangaListRoute({
    _i26.Key? key,
    required int userId,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          ProfileMangaListRoute.name,
          args: ProfileMangaListRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileMangaListRoute';

  static const _i25.PageInfo<ProfileMangaListRouteArgs> page =
      _i25.PageInfo<ProfileMangaListRouteArgs>(name);
}

class ProfileMangaListRouteArgs {
  const ProfileMangaListRouteArgs({
    this.key,
    required this.userId,
  });

  final _i26.Key? key;

  final int userId;

  @override
  String toString() {
    return 'ProfileMangaListRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i16.ProfilePage]
class ProfileRoute extends _i25.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i26.Key? key,
    required String name,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            name: name,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i25.PageInfo<ProfileRouteArgs> page =
      _i25.PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.name,
  });

  final _i26.Key? key;

  final String name;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, name: $name}';
  }
}

/// generated route for
/// [_i17.Review]
class Review extends _i25.PageRouteInfo<ReviewArgs> {
  Review({
    _i26.Key? key,
    required int id,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          Review.name,
          args: ReviewArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'Review';

  static const _i25.PageInfo<ReviewArgs> page = _i25.PageInfo<ReviewArgs>(name);
}

class ReviewArgs {
  const ReviewArgs({
    this.key,
    required this.id,
  });

  final _i26.Key? key;

  final int id;

  @override
  String toString() {
    return 'ReviewArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i18.SearchPage]
class SearchRoute extends _i25.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i26.Key? key,
    bool? isAdult,
    dynamic type,
    List<dynamic>? sort,
    int? year,
    dynamic season,
    String? search,
    List<String>? genres,
    bool? hideOnList,
    List<dynamic>? tags,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(
            key: key,
            isAdult: isAdult,
            type: type,
            sort: sort,
            year: year,
            season: season,
            search: search,
            genres: genres,
            hideOnList: hideOnList,
            tags: tags,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i25.PageInfo<SearchRouteArgs> page =
      _i25.PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    this.isAdult,
    this.type,
    this.sort,
    this.year,
    this.season,
    this.search,
    this.genres,
    this.hideOnList,
    this.tags,
  });

  final _i26.Key? key;

  final bool? isAdult;

  final dynamic type;

  final List<dynamic>? sort;

  final int? year;

  final dynamic season;

  final String? search;

  final List<String>? genres;

  final bool? hideOnList;

  final List<dynamic>? tags;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, isAdult: $isAdult, type: $type, sort: $sort, year: $year, season: $season, search: $search, genres: $genres, hideOnList: $hideOnList, tags: $tags}';
  }
}

/// generated route for
/// [_i19.AppSettingsPage]
class AppSettingsRoute extends _i25.PageRouteInfo<void> {
  const AppSettingsRoute({List<_i25.PageRouteInfo>? children})
      : super(
          AppSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppSettingsRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i20.ColorsPage]
class ColorsRoute extends _i25.PageRouteInfo<void> {
  const ColorsRoute({List<_i25.PageRouteInfo>? children})
      : super(
          ColorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ColorsRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i21.SettingsPage]
class SettingsRoute extends _i25.PageRouteInfo<void> {
  const SettingsRoute({List<_i25.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i22.StaffPage]
class StaffRoute extends _i25.PageRouteInfo<StaffRouteArgs> {
  StaffRoute({
    _i26.Key? key,
    required int id,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          StaffRoute.name,
          args: StaffRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'StaffRoute';

  static const _i25.PageInfo<StaffRouteArgs> page =
      _i25.PageInfo<StaffRouteArgs>(name);
}

class StaffRouteArgs {
  const StaffRouteArgs({
    this.key,
    required this.id,
  });

  final _i26.Key? key;

  final int id;

  @override
  String toString() {
    return 'StaffRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i23.ThreadPage]
class ThreadRoute extends _i25.PageRouteInfo<ThreadRouteArgs> {
  ThreadRoute({
    required int id,
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          ThreadRoute.name,
          args: ThreadRouteArgs(
            id: id,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ThreadRoute';

  static const _i25.PageInfo<ThreadRouteArgs> page =
      _i25.PageInfo<ThreadRouteArgs>(name);
}

class ThreadRouteArgs {
  const ThreadRouteArgs({
    required this.id,
    this.key,
  });

  final int id;

  final _i26.Key? key;

  @override
  String toString() {
    return 'ThreadRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i24.ThreadsPage]
class ThreadsRoute extends _i25.PageRouteInfo<ThreadsRouteArgs> {
  ThreadsRoute({
    _i26.Key? key,
    required _i24.ThreadFeed feed,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          ThreadsRoute.name,
          args: ThreadsRouteArgs(
            key: key,
            feed: feed,
          ),
          initialChildren: children,
        );

  static const String name = 'ThreadsRoute';

  static const _i25.PageInfo<ThreadsRouteArgs> page =
      _i25.PageInfo<ThreadsRouteArgs>(name);
}

class ThreadsRouteArgs {
  const ThreadsRouteArgs({
    this.key,
    required this.feed,
  });

  final _i26.Key? key;

  final _i24.ThreadFeed feed;

  @override
  String toString() {
    return 'ThreadsRouteArgs{key: $key, feed: $feed}';
  }
}
