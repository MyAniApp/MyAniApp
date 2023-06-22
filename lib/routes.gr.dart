// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:flutter/material.dart' as _i26;
import 'package:myaniapp/ui/routes/activity/activity.dart' as _i1;
import 'package:myaniapp/ui/routes/auth/auth.dart' as _i2;
import 'package:myaniapp/ui/routes/character/character.dart' as _i23;
import 'package:myaniapp/ui/routes/explore/explore.dart' as _i3;
import 'package:myaniapp/ui/routes/home/activities/activities.dart' as _i4;
import 'package:myaniapp/ui/routes/home/home.dart' as _i5;
import 'package:myaniapp/ui/routes/home/list/anime.dart' as _i6;
import 'package:myaniapp/ui/routes/home/list/manga.dart' as _i7;
import 'package:myaniapp/ui/routes/home/overview/overview.dart' as _i8;
import 'package:myaniapp/ui/routes/login/anilist.dart' as _i9;
import 'package:myaniapp/ui/routes/login/login.dart' as _i10;
import 'package:myaniapp/ui/routes/login/token.dart' as _i11;
import 'package:myaniapp/ui/routes/media/characters/characters.dart' as _i12;
import 'package:myaniapp/ui/routes/media/media.dart' as _i13;
import 'package:myaniapp/ui/routes/media/overview.dart' as _i14;
import 'package:myaniapp/ui/routes/media/relations.dart' as _i15;
import 'package:myaniapp/ui/routes/media/reviews/reviews.dart' as _i16;
import 'package:myaniapp/ui/routes/media/similar/similar.dart' as _i17;
import 'package:myaniapp/ui/routes/media/social/social.dart' as _i18;
import 'package:myaniapp/ui/routes/media/staff/staff.dart' as _i19;
import 'package:myaniapp/ui/routes/review/review.dart' as _i20;
import 'package:myaniapp/ui/routes/search/search.dart' as _i21;
import 'package:myaniapp/ui/routes/staff/staff.dart' as _i24;
import 'package:myaniapp/ui/routes/thread/thread.dart' as _i22;

abstract class $AppRouter extends _i25.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i25.PageFactory> pagesMap = {
    ActivityRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ActivityRouteArgs>(
          orElse: () => ActivityRouteArgs(id: pathParams.getInt('id')));
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ActivityPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    AuthRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<AuthRouteArgs>(
          orElse: () => AuthRouteArgs(
              accessToken: queryParams.optString('access_token')));
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AuthPage(
          key: args.key,
          accessToken: args.accessToken,
        ),
      );
    },
    ExploreRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ExplorePage(),
      );
    },
    HomeActivitiesRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeActivitiesPage(),
      );
    },
    MyHomeRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MyHomePage(),
      );
    },
    HomeAnimeRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeAnimePage(),
      );
    },
    HomeMangaRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeMangaPage(),
      );
    },
    HomeOverviewRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HomeOverviewPage(),
      );
    },
    AniLoginRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.AniLoginPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginPage(),
      );
    },
    TokenLoginRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.TokenLoginPage(),
      );
    },
    MediaCharactersRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaCharactersRouteArgs>(
          orElse: () => MediaCharactersRouteArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.MediaCharactersPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaRouteArgs>(
          orElse: () => MediaRouteArgs(id: pathParams.getInt('id')));
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.MediaPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    MediaOverviewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaOverviewRouteArgs>(
          orElse: () => MediaOverviewRouteArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.MediaOverviewPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaRelationsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaRelationsRouteArgs>(
          orElse: () => MediaRelationsRouteArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.MediaRelationsPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaReviewsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaReviewsRouteArgs>(
          orElse: () => MediaReviewsRouteArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.MediaReviewsPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaSimilarRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaSimilarRouteArgs>(
          orElse: () => MediaSimilarRouteArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.MediaSimilarPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaSocialRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaSocialRouteArgs>(
          orElse: () => MediaSocialRouteArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.MediaSocialPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaStaffRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaStaffRouteArgs>(
          orElse: () => MediaStaffRouteArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.MediaStaffPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    ReviewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ReviewRouteArgs>(
          orElse: () => ReviewRouteArgs(id: pathParams.getInt('id')));
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.ReviewPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<SearchRouteArgs>(
          orElse: () => SearchRouteArgs(
                sort: queryParams.get(
                  'sort',
                  '',
                ),
                search: queryParams.optString('search'),
                type: queryParams.optString('type'),
              ));
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.SearchPage(
          key: args.key,
          sort: args.sort,
          search: args.search,
          type: args.type,
        ),
      );
    },
    ThreadRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ThreadRouteArgs>(
          orElse: () => ThreadRouteArgs(id: pathParams.getInt('id')));
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.ThreadPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    CharacterRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CharacterRouteArgs>(
          orElse: () => CharacterRouteArgs(id: pathParams.getInt('id')));
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.CharacterPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    StaffRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<StaffRouteArgs>(
          orElse: () => StaffRouteArgs(id: pathParams.getInt('id')));
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.StaffPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ActivityPage]
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
          rawPathParams: {'id': id},
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
/// [_i2.AuthPage]
class AuthRoute extends _i25.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i26.Key? key,
    String? accessToken,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(
            key: key,
            accessToken: accessToken,
          ),
          rawQueryParams: {'access_token': accessToken},
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i25.PageInfo<AuthRouteArgs> page =
      _i25.PageInfo<AuthRouteArgs>(name);
}

class AuthRouteArgs {
  const AuthRouteArgs({
    this.key,
    this.accessToken,
  });

  final _i26.Key? key;

  final String? accessToken;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, accessToken: $accessToken}';
  }
}

/// generated route for
/// [_i3.ExplorePage]
class ExploreRoute extends _i25.PageRouteInfo<void> {
  const ExploreRoute({List<_i25.PageRouteInfo>? children})
      : super(
          ExploreRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExploreRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeActivitiesPage]
class HomeActivitiesRoute extends _i25.PageRouteInfo<void> {
  const HomeActivitiesRoute({List<_i25.PageRouteInfo>? children})
      : super(
          HomeActivitiesRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeActivitiesRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MyHomePage]
class MyHomeRoute extends _i25.PageRouteInfo<void> {
  const MyHomeRoute({List<_i25.PageRouteInfo>? children})
      : super(
          MyHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeAnimePage]
class HomeAnimeRoute extends _i25.PageRouteInfo<void> {
  const HomeAnimeRoute({List<_i25.PageRouteInfo>? children})
      : super(
          HomeAnimeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeAnimeRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeMangaPage]
class HomeMangaRoute extends _i25.PageRouteInfo<void> {
  const HomeMangaRoute({List<_i25.PageRouteInfo>? children})
      : super(
          HomeMangaRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeMangaRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HomeOverviewPage]
class HomeOverviewRoute extends _i25.PageRouteInfo<void> {
  const HomeOverviewRoute({List<_i25.PageRouteInfo>? children})
      : super(
          HomeOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeOverviewRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i9.AniLoginPage]
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
/// [_i10.LoginPage]
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
/// [_i11.TokenLoginPage]
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
/// [_i12.MediaCharactersPage]
class MediaCharactersRoute
    extends _i25.PageRouteInfo<MediaCharactersRouteArgs> {
  MediaCharactersRoute({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          MediaCharactersRoute.name,
          args: MediaCharactersRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaCharactersRoute';

  static const _i25.PageInfo<MediaCharactersRouteArgs> page =
      _i25.PageInfo<MediaCharactersRouteArgs>(name);
}

class MediaCharactersRouteArgs {
  const MediaCharactersRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'MediaCharactersRouteArgs{key: $key}';
  }
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
          rawPathParams: {'id': id},
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
/// [_i14.MediaOverviewPage]
class MediaOverviewRoute extends _i25.PageRouteInfo<MediaOverviewRouteArgs> {
  MediaOverviewRoute({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          MediaOverviewRoute.name,
          args: MediaOverviewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaOverviewRoute';

  static const _i25.PageInfo<MediaOverviewRouteArgs> page =
      _i25.PageInfo<MediaOverviewRouteArgs>(name);
}

class MediaOverviewRouteArgs {
  const MediaOverviewRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'MediaOverviewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.MediaRelationsPage]
class MediaRelationsRoute extends _i25.PageRouteInfo<MediaRelationsRouteArgs> {
  MediaRelationsRoute({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          MediaRelationsRoute.name,
          args: MediaRelationsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaRelationsRoute';

  static const _i25.PageInfo<MediaRelationsRouteArgs> page =
      _i25.PageInfo<MediaRelationsRouteArgs>(name);
}

class MediaRelationsRouteArgs {
  const MediaRelationsRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'MediaRelationsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.MediaReviewsPage]
class MediaReviewsRoute extends _i25.PageRouteInfo<MediaReviewsRouteArgs> {
  MediaReviewsRoute({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          MediaReviewsRoute.name,
          args: MediaReviewsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaReviewsRoute';

  static const _i25.PageInfo<MediaReviewsRouteArgs> page =
      _i25.PageInfo<MediaReviewsRouteArgs>(name);
}

class MediaReviewsRouteArgs {
  const MediaReviewsRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'MediaReviewsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.MediaSimilarPage]
class MediaSimilarRoute extends _i25.PageRouteInfo<MediaSimilarRouteArgs> {
  MediaSimilarRoute({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          MediaSimilarRoute.name,
          args: MediaSimilarRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaSimilarRoute';

  static const _i25.PageInfo<MediaSimilarRouteArgs> page =
      _i25.PageInfo<MediaSimilarRouteArgs>(name);
}

class MediaSimilarRouteArgs {
  const MediaSimilarRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'MediaSimilarRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.MediaSocialPage]
class MediaSocialRoute extends _i25.PageRouteInfo<MediaSocialRouteArgs> {
  MediaSocialRoute({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          MediaSocialRoute.name,
          args: MediaSocialRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaSocialRoute';

  static const _i25.PageInfo<MediaSocialRouteArgs> page =
      _i25.PageInfo<MediaSocialRouteArgs>(name);
}

class MediaSocialRouteArgs {
  const MediaSocialRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'MediaSocialRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.MediaStaffPage]
class MediaStaffRoute extends _i25.PageRouteInfo<MediaStaffRouteArgs> {
  MediaStaffRoute({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          MediaStaffRoute.name,
          args: MediaStaffRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaStaffRoute';

  static const _i25.PageInfo<MediaStaffRouteArgs> page =
      _i25.PageInfo<MediaStaffRouteArgs>(name);
}

class MediaStaffRouteArgs {
  const MediaStaffRouteArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'MediaStaffRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.ReviewPage]
class ReviewRoute extends _i25.PageRouteInfo<ReviewRouteArgs> {
  ReviewRoute({
    _i26.Key? key,
    required int id,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          ReviewRoute.name,
          args: ReviewRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'ReviewRoute';

  static const _i25.PageInfo<ReviewRouteArgs> page =
      _i25.PageInfo<ReviewRouteArgs>(name);
}

class ReviewRouteArgs {
  const ReviewRouteArgs({
    this.key,
    required this.id,
  });

  final _i26.Key? key;

  final int id;

  @override
  String toString() {
    return 'ReviewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i21.SearchPage]
class SearchRoute extends _i25.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i26.Key? key,
    dynamic sort = '',
    String? search,
    String? type,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(
            key: key,
            sort: sort,
            search: search,
            type: type,
          ),
          rawQueryParams: {
            'sort': sort,
            'search': search,
            'type': type,
          },
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i25.PageInfo<SearchRouteArgs> page =
      _i25.PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    this.sort = '',
    this.search,
    this.type,
  });

  final _i26.Key? key;

  final dynamic sort;

  final String? search;

  final String? type;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, sort: $sort, search: $search, type: $type}';
  }
}

/// generated route for
/// [_i22.ThreadPage]
class ThreadRoute extends _i25.PageRouteInfo<ThreadRouteArgs> {
  ThreadRoute({
    _i26.Key? key,
    required int id,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          ThreadRoute.name,
          args: ThreadRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'ThreadRoute';

  static const _i25.PageInfo<ThreadRouteArgs> page =
      _i25.PageInfo<ThreadRouteArgs>(name);
}

class ThreadRouteArgs {
  const ThreadRouteArgs({
    this.key,
    required this.id,
  });

  final _i26.Key? key;

  final int id;

  @override
  String toString() {
    return 'ThreadRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i23.CharacterPage]
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
          rawPathParams: {'id': id},
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
/// [_i24.StaffPage]
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
          rawPathParams: {'id': id},
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
