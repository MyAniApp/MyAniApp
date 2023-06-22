// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i23;
import 'package:flutter/material.dart' as _i24;
import 'package:myaniapp/ui/routes/activity/activity.dart' as _i22;
import 'package:myaniapp/ui/routes/auth/auth.dart' as _i1;
import 'package:myaniapp/ui/routes/explore/explore.dart' as _i2;
import 'package:myaniapp/ui/routes/home/activities/activities.dart' as _i21;
import 'package:myaniapp/ui/routes/home/home.dart' as _i3;
import 'package:myaniapp/ui/routes/home/list/anime.dart' as _i4;
import 'package:myaniapp/ui/routes/home/list/manga.dart' as _i5;
import 'package:myaniapp/ui/routes/home/overview/overview.dart' as _i6;
import 'package:myaniapp/ui/routes/login/anilist.dart' as _i7;
import 'package:myaniapp/ui/routes/login/login.dart' as _i8;
import 'package:myaniapp/ui/routes/login/token.dart' as _i9;
import 'package:myaniapp/ui/routes/media/characters/characters.dart' as _i10;
import 'package:myaniapp/ui/routes/media/media.dart' as _i11;
import 'package:myaniapp/ui/routes/media/overview.dart' as _i12;
import 'package:myaniapp/ui/routes/media/relations.dart' as _i13;
import 'package:myaniapp/ui/routes/media/reviews/reviews.dart' as _i14;
import 'package:myaniapp/ui/routes/media/similar/similar.dart' as _i15;
import 'package:myaniapp/ui/routes/media/social/social.dart' as _i16;
import 'package:myaniapp/ui/routes/media/staff/staff.dart' as _i17;
import 'package:myaniapp/ui/routes/review/review.dart' as _i18;
import 'package:myaniapp/ui/routes/search/search.dart' as _i19;
import 'package:myaniapp/ui/routes/thread/thread.dart' as _i20;

abstract class $AppRouter extends _i23.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i23.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<AuthRouteArgs>(
          orElse: () => AuthRouteArgs(
              accessToken: queryParams.optString('access_token')));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AuthPage(
          key: args.key,
          accessToken: args.accessToken,
        ),
      );
    },
    ExploreRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ExplorePage(),
      );
    },
    MyHomeRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MyHomePage(),
      );
    },
    HomeAnimeRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeAnimePage(),
      );
    },
    HomeMangaRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeMangaPage(),
      );
    },
    HomeOverviewRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeOverviewPage(),
      );
    },
    AniLoginRoute.name: (routeData) {
      final args = routeData.argsAs<AniLoginRouteArgs>(
          orElse: () => const AniLoginRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.AniLoginPage(key: args.key),
      );
    },
    LoginRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LoginPage(),
      );
    },
    TokenLoginRoute.name: (routeData) {
      final args = routeData.argsAs<TokenLoginRouteArgs>(
          orElse: () => const TokenLoginRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.TokenLoginPage(key: args.key),
      );
    },
    MediaCharactersRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaCharactersRouteArgs>(
          orElse: () => MediaCharactersRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.MediaCharactersPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaRouteArgs>(
          orElse: () => MediaRouteArgs(id: pathParams.getInt('id')));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.MediaPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    MediaOverviewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaOverviewRouteArgs>(
          orElse: () => MediaOverviewRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.MediaOverviewPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaRelationsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaRelationsRouteArgs>(
          orElse: () => MediaRelationsRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.MediaRelationsPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaReviewsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaReviewsRouteArgs>(
          orElse: () => MediaReviewsRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.MediaReviewsPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaSimilarRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaSimilarRouteArgs>(
          orElse: () => MediaSimilarRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.MediaSimilarPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaSocialRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaSocialRouteArgs>(
          orElse: () => MediaSocialRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.MediaSocialPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaStaffRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaStaffRouteArgs>(
          orElse: () => MediaStaffRouteArgs());
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.MediaStaffPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    ReviewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ReviewRouteArgs>(
          orElse: () => ReviewRouteArgs(id: pathParams.getInt('id')));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.ReviewPage(
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
              ));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.SearchPage(
          key: args.key,
          sort: args.sort,
          search: args.search,
        ),
      );
    },
    ThreadRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ThreadRouteArgs>(
          orElse: () => ThreadRouteArgs(id: pathParams.getInt('id')));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.ThreadPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    HomeActivitiesRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.HomeActivitiesPage(),
      );
    },
    ActivityRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ActivityRouteArgs>(
          orElse: () => ActivityRouteArgs(id: pathParams.getInt('id')));
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.ActivityPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i23.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i24.Key? key,
    String? accessToken,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<AuthRouteArgs> page =
      _i23.PageInfo<AuthRouteArgs>(name);
}

class AuthRouteArgs {
  const AuthRouteArgs({
    this.key,
    this.accessToken,
  });

  final _i24.Key? key;

  final String? accessToken;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, accessToken: $accessToken}';
  }
}

/// generated route for
/// [_i2.ExplorePage]
class ExploreRoute extends _i23.PageRouteInfo<void> {
  const ExploreRoute({List<_i23.PageRouteInfo>? children})
      : super(
          ExploreRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExploreRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MyHomePage]
class MyHomeRoute extends _i23.PageRouteInfo<void> {
  const MyHomeRoute({List<_i23.PageRouteInfo>? children})
      : super(
          MyHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeAnimePage]
class HomeAnimeRoute extends _i23.PageRouteInfo<void> {
  const HomeAnimeRoute({List<_i23.PageRouteInfo>? children})
      : super(
          HomeAnimeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeAnimeRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomeMangaPage]
class HomeMangaRoute extends _i23.PageRouteInfo<void> {
  const HomeMangaRoute({List<_i23.PageRouteInfo>? children})
      : super(
          HomeMangaRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeMangaRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeOverviewPage]
class HomeOverviewRoute extends _i23.PageRouteInfo<void> {
  const HomeOverviewRoute({List<_i23.PageRouteInfo>? children})
      : super(
          HomeOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeOverviewRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i7.AniLoginPage]
class AniLoginRoute extends _i23.PageRouteInfo<AniLoginRouteArgs> {
  AniLoginRoute({
    dynamic key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          AniLoginRoute.name,
          args: AniLoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AniLoginRoute';

  static const _i23.PageInfo<AniLoginRouteArgs> page =
      _i23.PageInfo<AniLoginRouteArgs>(name);
}

class AniLoginRouteArgs {
  const AniLoginRouteArgs({this.key});

  final dynamic key;

  @override
  String toString() {
    return 'AniLoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i23.PageRouteInfo<void> {
  const LoginRoute({List<_i23.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i9.TokenLoginPage]
class TokenLoginRoute extends _i23.PageRouteInfo<TokenLoginRouteArgs> {
  TokenLoginRoute({
    dynamic key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          TokenLoginRoute.name,
          args: TokenLoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'TokenLoginRoute';

  static const _i23.PageInfo<TokenLoginRouteArgs> page =
      _i23.PageInfo<TokenLoginRouteArgs>(name);
}

class TokenLoginRouteArgs {
  const TokenLoginRouteArgs({this.key});

  final dynamic key;

  @override
  String toString() {
    return 'TokenLoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.MediaCharactersPage]
class MediaCharactersRoute
    extends _i23.PageRouteInfo<MediaCharactersRouteArgs> {
  MediaCharactersRoute({
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          MediaCharactersRoute.name,
          args: MediaCharactersRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaCharactersRoute';

  static const _i23.PageInfo<MediaCharactersRouteArgs> page =
      _i23.PageInfo<MediaCharactersRouteArgs>(name);
}

class MediaCharactersRouteArgs {
  const MediaCharactersRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'MediaCharactersRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.MediaPage]
class MediaRoute extends _i23.PageRouteInfo<MediaRouteArgs> {
  MediaRoute({
    _i24.Key? key,
    required int id,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<MediaRouteArgs> page =
      _i23.PageInfo<MediaRouteArgs>(name);
}

class MediaRouteArgs {
  const MediaRouteArgs({
    this.key,
    required this.id,
  });

  final _i24.Key? key;

  final int id;

  @override
  String toString() {
    return 'MediaRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i12.MediaOverviewPage]
class MediaOverviewRoute extends _i23.PageRouteInfo<MediaOverviewRouteArgs> {
  MediaOverviewRoute({
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          MediaOverviewRoute.name,
          args: MediaOverviewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaOverviewRoute';

  static const _i23.PageInfo<MediaOverviewRouteArgs> page =
      _i23.PageInfo<MediaOverviewRouteArgs>(name);
}

class MediaOverviewRouteArgs {
  const MediaOverviewRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'MediaOverviewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.MediaRelationsPage]
class MediaRelationsRoute extends _i23.PageRouteInfo<MediaRelationsRouteArgs> {
  MediaRelationsRoute({
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          MediaRelationsRoute.name,
          args: MediaRelationsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaRelationsRoute';

  static const _i23.PageInfo<MediaRelationsRouteArgs> page =
      _i23.PageInfo<MediaRelationsRouteArgs>(name);
}

class MediaRelationsRouteArgs {
  const MediaRelationsRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'MediaRelationsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.MediaReviewsPage]
class MediaReviewsRoute extends _i23.PageRouteInfo<MediaReviewsRouteArgs> {
  MediaReviewsRoute({
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          MediaReviewsRoute.name,
          args: MediaReviewsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaReviewsRoute';

  static const _i23.PageInfo<MediaReviewsRouteArgs> page =
      _i23.PageInfo<MediaReviewsRouteArgs>(name);
}

class MediaReviewsRouteArgs {
  const MediaReviewsRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'MediaReviewsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.MediaSimilarPage]
class MediaSimilarRoute extends _i23.PageRouteInfo<MediaSimilarRouteArgs> {
  MediaSimilarRoute({
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          MediaSimilarRoute.name,
          args: MediaSimilarRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaSimilarRoute';

  static const _i23.PageInfo<MediaSimilarRouteArgs> page =
      _i23.PageInfo<MediaSimilarRouteArgs>(name);
}

class MediaSimilarRouteArgs {
  const MediaSimilarRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'MediaSimilarRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.MediaSocialPage]
class MediaSocialRoute extends _i23.PageRouteInfo<MediaSocialRouteArgs> {
  MediaSocialRoute({
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          MediaSocialRoute.name,
          args: MediaSocialRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaSocialRoute';

  static const _i23.PageInfo<MediaSocialRouteArgs> page =
      _i23.PageInfo<MediaSocialRouteArgs>(name);
}

class MediaSocialRouteArgs {
  const MediaSocialRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'MediaSocialRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.MediaStaffPage]
class MediaStaffRoute extends _i23.PageRouteInfo<MediaStaffRouteArgs> {
  MediaStaffRoute({
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          MediaStaffRoute.name,
          args: MediaStaffRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaStaffRoute';

  static const _i23.PageInfo<MediaStaffRouteArgs> page =
      _i23.PageInfo<MediaStaffRouteArgs>(name);
}

class MediaStaffRouteArgs {
  const MediaStaffRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'MediaStaffRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.ReviewPage]
class ReviewRoute extends _i23.PageRouteInfo<ReviewRouteArgs> {
  ReviewRoute({
    _i24.Key? key,
    required int id,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<ReviewRouteArgs> page =
      _i23.PageInfo<ReviewRouteArgs>(name);
}

class ReviewRouteArgs {
  const ReviewRouteArgs({
    this.key,
    required this.id,
  });

  final _i24.Key? key;

  final int id;

  @override
  String toString() {
    return 'ReviewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i19.SearchPage]
class SearchRoute extends _i23.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i24.Key? key,
    dynamic sort = '',
    String? search,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(
            key: key,
            sort: sort,
            search: search,
          ),
          rawQueryParams: {
            'sort': sort,
            'search': search,
          },
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i23.PageInfo<SearchRouteArgs> page =
      _i23.PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    this.sort = '',
    this.search,
  });

  final _i24.Key? key;

  final dynamic sort;

  final String? search;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, sort: $sort, search: $search}';
  }
}

/// generated route for
/// [_i20.ThreadPage]
class ThreadRoute extends _i23.PageRouteInfo<ThreadRouteArgs> {
  ThreadRoute({
    _i24.Key? key,
    required int id,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<ThreadRouteArgs> page =
      _i23.PageInfo<ThreadRouteArgs>(name);
}

class ThreadRouteArgs {
  const ThreadRouteArgs({
    this.key,
    required this.id,
  });

  final _i24.Key? key;

  final int id;

  @override
  String toString() {
    return 'ThreadRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i21.HomeActivitiesPage]
class HomeActivitiesRoute extends _i23.PageRouteInfo<void> {
  const HomeActivitiesRoute({List<_i23.PageRouteInfo>? children})
      : super(
          HomeActivitiesRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeActivitiesRoute';

  static const _i23.PageInfo<void> page = _i23.PageInfo<void>(name);
}

/// generated route for
/// [_i22.ActivityPage]
class ActivityRoute extends _i23.PageRouteInfo<ActivityRouteArgs> {
  ActivityRoute({
    _i24.Key? key,
    required int id,
    List<_i23.PageRouteInfo>? children,
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

  static const _i23.PageInfo<ActivityRouteArgs> page =
      _i23.PageInfo<ActivityRouteArgs>(name);
}

class ActivityRouteArgs {
  const ActivityRouteArgs({
    this.key,
    required this.id,
  });

  final _i24.Key? key;

  final int id;

  @override
  String toString() {
    return 'ActivityRouteArgs{key: $key, id: $id}';
  }
}
