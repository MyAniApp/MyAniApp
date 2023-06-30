// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i33;
import 'package:flutter/material.dart' as _i34;
import 'package:myaniapp/ui/routes/activity/activity.dart' as _i1;
import 'package:myaniapp/ui/routes/auth/auth.dart' as _i2;
import 'package:myaniapp/ui/routes/character/character.dart' as _i3;
import 'package:myaniapp/ui/routes/explore/explore.dart' as _i4;
import 'package:myaniapp/ui/routes/home/activities/activities.dart' as _i5;
import 'package:myaniapp/ui/routes/home/home.dart' as _i6;
import 'package:myaniapp/ui/routes/home/list/anime.dart' as _i7;
import 'package:myaniapp/ui/routes/home/list/manga.dart' as _i8;
import 'package:myaniapp/ui/routes/home/overview/overview.dart' as _i9;
import 'package:myaniapp/ui/routes/login/anilist.dart' as _i10;
import 'package:myaniapp/ui/routes/login/login.dart' as _i11;
import 'package:myaniapp/ui/routes/login/token.dart' as _i12;
import 'package:myaniapp/ui/routes/media/characters/characters.dart' as _i13;
import 'package:myaniapp/ui/routes/media/media.dart' as _i14;
import 'package:myaniapp/ui/routes/media/overview.dart' as _i15;
import 'package:myaniapp/ui/routes/media/relations.dart' as _i16;
import 'package:myaniapp/ui/routes/media/reviews/reviews.dart' as _i17;
import 'package:myaniapp/ui/routes/media/similar/similar.dart' as _i18;
import 'package:myaniapp/ui/routes/media/social/social.dart' as _i19;
import 'package:myaniapp/ui/routes/media/staff/staff.dart' as _i20;
import 'package:myaniapp/ui/routes/recommendations/recommendations.dart'
    as _i21;
import 'package:myaniapp/ui/routes/review/review.dart' as _i22;
import 'package:myaniapp/ui/routes/search/search.dart' as _i23;
import 'package:myaniapp/ui/routes/staff/staff.dart' as _i24;
import 'package:myaniapp/ui/routes/thread/thread.dart' as _i25;
import 'package:myaniapp/ui/routes/user/activity/activity.dart' as _i26;
import 'package:myaniapp/ui/routes/user/list/anime.dart' as _i27;
import 'package:myaniapp/ui/routes/user/list/manga.dart' as _i28;
import 'package:myaniapp/ui/routes/user/overview.dart' as _i29;
import 'package:myaniapp/ui/routes/user/reviews/reviews.dart' as _i30;
import 'package:myaniapp/ui/routes/user/social/social.dart' as _i31;
import 'package:myaniapp/ui/routes/user/user.dart' as _i32;

abstract class $AppRouter extends _i33.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i33.PageFactory> pagesMap = {
    ActivityRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ActivityRouteArgs>(
          orElse: () => ActivityRouteArgs(id: pathParams.getInt('id')));
      return _i33.AutoRoutePage<dynamic>(
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
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AuthPage(
          key: args.key,
          accessToken: args.accessToken,
        ),
      );
    },
    CharacterRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CharacterRouteArgs>(
          orElse: () => CharacterRouteArgs(id: pathParams.getInt('id')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CharacterPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    ExploreRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ExplorePage(),
      );
    },
    HomeActivitiesRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeActivitiesPage(),
      );
    },
    MyHomeRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.MyHomePage(),
      );
    },
    HomeAnimeRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeAnimePage(),
      );
    },
    HomeMangaRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HomeMangaPage(),
      );
    },
    HomeOverviewRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HomeOverviewPage(),
      );
    },
    AniLoginRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.AniLoginPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.LoginPage(),
      );
    },
    TokenLoginRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.TokenLoginPage(),
      );
    },
    MediaCharactersRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaCharactersRouteArgs>(
          orElse: () => MediaCharactersRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.MediaCharactersPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaRouteArgs>(
          orElse: () => MediaRouteArgs(id: pathParams.getInt('id')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.MediaPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    MediaOverviewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaOverviewRouteArgs>(
          orElse: () => MediaOverviewRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.MediaOverviewPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaRelationsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaRelationsRouteArgs>(
          orElse: () => MediaRelationsRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.MediaRelationsPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaReviewsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaReviewsRouteArgs>(
          orElse: () => MediaReviewsRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.MediaReviewsPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaSimilarRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaSimilarRouteArgs>(
          orElse: () => MediaSimilarRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.MediaSimilarPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaSocialRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaSocialRouteArgs>(
          orElse: () => MediaSocialRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.MediaSocialPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    MediaStaffRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MediaStaffRouteArgs>(
          orElse: () => MediaStaffRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.MediaStaffPage(
          key: args.key,
          id: pathParams.getInt('id'),
        ),
      );
    },
    RecommendationsRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.RecommendationsPage(),
      );
    },
    ReviewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ReviewRouteArgs>(
          orElse: () => ReviewRouteArgs(id: pathParams.getInt('id')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.ReviewPage(
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
                genre: queryParams.get(
                  'genre',
                  '',
                ),
                tag: queryParams.get(
                  'tag',
                  '',
                ),
              ));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.SearchPage(
          key: args.key,
          sort: args.sort,
          search: args.search,
          type: args.type,
          genre: args.genre,
          tag: args.tag,
          autofocus: args.autofocus,
        ),
      );
    },
    StaffRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<StaffRouteArgs>(
          orElse: () => StaffRouteArgs(id: pathParams.getInt('id')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.StaffPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    ThreadRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ThreadRouteArgs>(
          orElse: () => ThreadRouteArgs(id: pathParams.getInt('id')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.ThreadPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
    UserActivityRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserActivityRouteArgs>(
          orElse: () => UserActivityRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.UserActivityPage(
          key: args.key,
          name: pathParams.getString('name'),
        ),
      );
    },
    UserAnimeListRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserAnimeListRouteArgs>(
          orElse: () =>
              UserAnimeListRouteArgs(name: pathParams.getString('name')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.UserAnimeListPage(
          key: args.key,
          name: args.name,
        ),
      );
    },
    UserMangaListRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserMangaListRouteArgs>(
          orElse: () =>
              UserMangaListRouteArgs(name: pathParams.getString('name')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.UserMangaListPage(
          key: args.key,
          name: args.name,
        ),
      );
    },
    UserOverviewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserOverviewRouteArgs>(
          orElse: () => UserOverviewRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i29.UserOverviewPage(
          key: args.key,
          name: pathParams.getString('name'),
        ),
      );
    },
    UserReviewsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserReviewsRouteArgs>(
          orElse: () => UserReviewsRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.UserReviewsPage(
          key: args.key,
          name: pathParams.getString('name'),
        ),
      );
    },
    UserSocialRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserSocialRouteArgs>(
          orElse: () => UserSocialRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i31.UserSocialPage(
          key: args.key,
          name: pathParams.getString('name'),
        ),
      );
    },
    UserRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserRouteArgs>(
          orElse: () => UserRouteArgs(name: pathParams.getString('name')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i32.UserPage(
          key: args.key,
          name: args.name,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ActivityPage]
class ActivityRoute extends _i33.PageRouteInfo<ActivityRouteArgs> {
  ActivityRoute({
    _i34.Key? key,
    required int id,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<ActivityRouteArgs> page =
      _i33.PageInfo<ActivityRouteArgs>(name);
}

class ActivityRouteArgs {
  const ActivityRouteArgs({
    this.key,
    required this.id,
  });

  final _i34.Key? key;

  final int id;

  @override
  String toString() {
    return 'ActivityRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i2.AuthPage]
class AuthRoute extends _i33.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i34.Key? key,
    String? accessToken,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<AuthRouteArgs> page =
      _i33.PageInfo<AuthRouteArgs>(name);
}

class AuthRouteArgs {
  const AuthRouteArgs({
    this.key,
    this.accessToken,
  });

  final _i34.Key? key;

  final String? accessToken;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, accessToken: $accessToken}';
  }
}

/// generated route for
/// [_i3.CharacterPage]
class CharacterRoute extends _i33.PageRouteInfo<CharacterRouteArgs> {
  CharacterRoute({
    _i34.Key? key,
    required int id,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<CharacterRouteArgs> page =
      _i33.PageInfo<CharacterRouteArgs>(name);
}

class CharacterRouteArgs {
  const CharacterRouteArgs({
    this.key,
    required this.id,
  });

  final _i34.Key? key;

  final int id;

  @override
  String toString() {
    return 'CharacterRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i4.ExplorePage]
class ExploreRoute extends _i33.PageRouteInfo<void> {
  const ExploreRoute({List<_i33.PageRouteInfo>? children})
      : super(
          ExploreRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExploreRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomeActivitiesPage]
class HomeActivitiesRoute extends _i33.PageRouteInfo<void> {
  const HomeActivitiesRoute({List<_i33.PageRouteInfo>? children})
      : super(
          HomeActivitiesRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeActivitiesRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MyHomePage]
class MyHomeRoute extends _i33.PageRouteInfo<void> {
  const MyHomeRoute({List<_i33.PageRouteInfo>? children})
      : super(
          MyHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeAnimePage]
class HomeAnimeRoute extends _i33.PageRouteInfo<void> {
  const HomeAnimeRoute({List<_i33.PageRouteInfo>? children})
      : super(
          HomeAnimeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeAnimeRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HomeMangaPage]
class HomeMangaRoute extends _i33.PageRouteInfo<void> {
  const HomeMangaRoute({List<_i33.PageRouteInfo>? children})
      : super(
          HomeMangaRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeMangaRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i9.HomeOverviewPage]
class HomeOverviewRoute extends _i33.PageRouteInfo<void> {
  const HomeOverviewRoute({List<_i33.PageRouteInfo>? children})
      : super(
          HomeOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeOverviewRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i10.AniLoginPage]
class AniLoginRoute extends _i33.PageRouteInfo<void> {
  const AniLoginRoute({List<_i33.PageRouteInfo>? children})
      : super(
          AniLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'AniLoginRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i11.LoginPage]
class LoginRoute extends _i33.PageRouteInfo<void> {
  const LoginRoute({List<_i33.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i12.TokenLoginPage]
class TokenLoginRoute extends _i33.PageRouteInfo<void> {
  const TokenLoginRoute({List<_i33.PageRouteInfo>? children})
      : super(
          TokenLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'TokenLoginRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i13.MediaCharactersPage]
class MediaCharactersRoute
    extends _i33.PageRouteInfo<MediaCharactersRouteArgs> {
  MediaCharactersRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          MediaCharactersRoute.name,
          args: MediaCharactersRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaCharactersRoute';

  static const _i33.PageInfo<MediaCharactersRouteArgs> page =
      _i33.PageInfo<MediaCharactersRouteArgs>(name);
}

class MediaCharactersRouteArgs {
  const MediaCharactersRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'MediaCharactersRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.MediaPage]
class MediaRoute extends _i33.PageRouteInfo<MediaRouteArgs> {
  MediaRoute({
    _i34.Key? key,
    required int id,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<MediaRouteArgs> page =
      _i33.PageInfo<MediaRouteArgs>(name);
}

class MediaRouteArgs {
  const MediaRouteArgs({
    this.key,
    required this.id,
  });

  final _i34.Key? key;

  final int id;

  @override
  String toString() {
    return 'MediaRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i15.MediaOverviewPage]
class MediaOverviewRoute extends _i33.PageRouteInfo<MediaOverviewRouteArgs> {
  MediaOverviewRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          MediaOverviewRoute.name,
          args: MediaOverviewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaOverviewRoute';

  static const _i33.PageInfo<MediaOverviewRouteArgs> page =
      _i33.PageInfo<MediaOverviewRouteArgs>(name);
}

class MediaOverviewRouteArgs {
  const MediaOverviewRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'MediaOverviewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.MediaRelationsPage]
class MediaRelationsRoute extends _i33.PageRouteInfo<MediaRelationsRouteArgs> {
  MediaRelationsRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          MediaRelationsRoute.name,
          args: MediaRelationsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaRelationsRoute';

  static const _i33.PageInfo<MediaRelationsRouteArgs> page =
      _i33.PageInfo<MediaRelationsRouteArgs>(name);
}

class MediaRelationsRouteArgs {
  const MediaRelationsRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'MediaRelationsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.MediaReviewsPage]
class MediaReviewsRoute extends _i33.PageRouteInfo<MediaReviewsRouteArgs> {
  MediaReviewsRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          MediaReviewsRoute.name,
          args: MediaReviewsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaReviewsRoute';

  static const _i33.PageInfo<MediaReviewsRouteArgs> page =
      _i33.PageInfo<MediaReviewsRouteArgs>(name);
}

class MediaReviewsRouteArgs {
  const MediaReviewsRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'MediaReviewsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.MediaSimilarPage]
class MediaSimilarRoute extends _i33.PageRouteInfo<MediaSimilarRouteArgs> {
  MediaSimilarRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          MediaSimilarRoute.name,
          args: MediaSimilarRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaSimilarRoute';

  static const _i33.PageInfo<MediaSimilarRouteArgs> page =
      _i33.PageInfo<MediaSimilarRouteArgs>(name);
}

class MediaSimilarRouteArgs {
  const MediaSimilarRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'MediaSimilarRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.MediaSocialPage]
class MediaSocialRoute extends _i33.PageRouteInfo<MediaSocialRouteArgs> {
  MediaSocialRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          MediaSocialRoute.name,
          args: MediaSocialRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaSocialRoute';

  static const _i33.PageInfo<MediaSocialRouteArgs> page =
      _i33.PageInfo<MediaSocialRouteArgs>(name);
}

class MediaSocialRouteArgs {
  const MediaSocialRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'MediaSocialRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.MediaStaffPage]
class MediaStaffRoute extends _i33.PageRouteInfo<MediaStaffRouteArgs> {
  MediaStaffRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          MediaStaffRoute.name,
          args: MediaStaffRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MediaStaffRoute';

  static const _i33.PageInfo<MediaStaffRouteArgs> page =
      _i33.PageInfo<MediaStaffRouteArgs>(name);
}

class MediaStaffRouteArgs {
  const MediaStaffRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'MediaStaffRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i21.RecommendationsPage]
class RecommendationsRoute extends _i33.PageRouteInfo<void> {
  const RecommendationsRoute({List<_i33.PageRouteInfo>? children})
      : super(
          RecommendationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecommendationsRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i22.ReviewPage]
class ReviewRoute extends _i33.PageRouteInfo<ReviewRouteArgs> {
  ReviewRoute({
    _i34.Key? key,
    required int id,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<ReviewRouteArgs> page =
      _i33.PageInfo<ReviewRouteArgs>(name);
}

class ReviewRouteArgs {
  const ReviewRouteArgs({
    this.key,
    required this.id,
  });

  final _i34.Key? key;

  final int id;

  @override
  String toString() {
    return 'ReviewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i23.SearchPage]
class SearchRoute extends _i33.PageRouteInfo<SearchRouteArgs> {
  SearchRoute({
    _i34.Key? key,
    dynamic sort = '',
    String? search,
    String? type,
    dynamic genre = '',
    dynamic tag = '',
    bool? autofocus,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          SearchRoute.name,
          args: SearchRouteArgs(
            key: key,
            sort: sort,
            search: search,
            type: type,
            genre: genre,
            tag: tag,
            autofocus: autofocus,
          ),
          rawQueryParams: {
            'sort': sort,
            'search': search,
            'type': type,
            'genre': genre,
            'tag': tag,
          },
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i33.PageInfo<SearchRouteArgs> page =
      _i33.PageInfo<SearchRouteArgs>(name);
}

class SearchRouteArgs {
  const SearchRouteArgs({
    this.key,
    this.sort = '',
    this.search,
    this.type,
    this.genre = '',
    this.tag = '',
    this.autofocus,
  });

  final _i34.Key? key;

  final dynamic sort;

  final String? search;

  final String? type;

  final dynamic genre;

  final dynamic tag;

  final bool? autofocus;

  @override
  String toString() {
    return 'SearchRouteArgs{key: $key, sort: $sort, search: $search, type: $type, genre: $genre, tag: $tag, autofocus: $autofocus}';
  }
}

/// generated route for
/// [_i24.StaffPage]
class StaffRoute extends _i33.PageRouteInfo<StaffRouteArgs> {
  StaffRoute({
    _i34.Key? key,
    required int id,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<StaffRouteArgs> page =
      _i33.PageInfo<StaffRouteArgs>(name);
}

class StaffRouteArgs {
  const StaffRouteArgs({
    this.key,
    required this.id,
  });

  final _i34.Key? key;

  final int id;

  @override
  String toString() {
    return 'StaffRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i25.ThreadPage]
class ThreadRoute extends _i33.PageRouteInfo<ThreadRouteArgs> {
  ThreadRoute({
    _i34.Key? key,
    required int id,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<ThreadRouteArgs> page =
      _i33.PageInfo<ThreadRouteArgs>(name);
}

class ThreadRouteArgs {
  const ThreadRouteArgs({
    this.key,
    required this.id,
  });

  final _i34.Key? key;

  final int id;

  @override
  String toString() {
    return 'ThreadRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i26.UserActivityPage]
class UserActivityRoute extends _i33.PageRouteInfo<UserActivityRouteArgs> {
  UserActivityRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          UserActivityRoute.name,
          args: UserActivityRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UserActivityRoute';

  static const _i33.PageInfo<UserActivityRouteArgs> page =
      _i33.PageInfo<UserActivityRouteArgs>(name);
}

class UserActivityRouteArgs {
  const UserActivityRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'UserActivityRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i27.UserAnimeListPage]
class UserAnimeListRoute extends _i33.PageRouteInfo<UserAnimeListRouteArgs> {
  UserAnimeListRoute({
    _i34.Key? key,
    required String name,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          UserAnimeListRoute.name,
          args: UserAnimeListRouteArgs(
            key: key,
            name: name,
          ),
          rawPathParams: {'name': name},
          initialChildren: children,
        );

  static const String name = 'UserAnimeListRoute';

  static const _i33.PageInfo<UserAnimeListRouteArgs> page =
      _i33.PageInfo<UserAnimeListRouteArgs>(name);
}

class UserAnimeListRouteArgs {
  const UserAnimeListRouteArgs({
    this.key,
    required this.name,
  });

  final _i34.Key? key;

  final String name;

  @override
  String toString() {
    return 'UserAnimeListRouteArgs{key: $key, name: $name}';
  }
}

/// generated route for
/// [_i28.UserMangaListPage]
class UserMangaListRoute extends _i33.PageRouteInfo<UserMangaListRouteArgs> {
  UserMangaListRoute({
    _i34.Key? key,
    required String name,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          UserMangaListRoute.name,
          args: UserMangaListRouteArgs(
            key: key,
            name: name,
          ),
          rawPathParams: {'name': name},
          initialChildren: children,
        );

  static const String name = 'UserMangaListRoute';

  static const _i33.PageInfo<UserMangaListRouteArgs> page =
      _i33.PageInfo<UserMangaListRouteArgs>(name);
}

class UserMangaListRouteArgs {
  const UserMangaListRouteArgs({
    this.key,
    required this.name,
  });

  final _i34.Key? key;

  final String name;

  @override
  String toString() {
    return 'UserMangaListRouteArgs{key: $key, name: $name}';
  }
}

/// generated route for
/// [_i29.UserOverviewPage]
class UserOverviewRoute extends _i33.PageRouteInfo<UserOverviewRouteArgs> {
  UserOverviewRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          UserOverviewRoute.name,
          args: UserOverviewRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UserOverviewRoute';

  static const _i33.PageInfo<UserOverviewRouteArgs> page =
      _i33.PageInfo<UserOverviewRouteArgs>(name);
}

class UserOverviewRouteArgs {
  const UserOverviewRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'UserOverviewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i30.UserReviewsPage]
class UserReviewsRoute extends _i33.PageRouteInfo<UserReviewsRouteArgs> {
  UserReviewsRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          UserReviewsRoute.name,
          args: UserReviewsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UserReviewsRoute';

  static const _i33.PageInfo<UserReviewsRouteArgs> page =
      _i33.PageInfo<UserReviewsRouteArgs>(name);
}

class UserReviewsRouteArgs {
  const UserReviewsRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'UserReviewsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i31.UserSocialPage]
class UserSocialRoute extends _i33.PageRouteInfo<UserSocialRouteArgs> {
  UserSocialRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          UserSocialRoute.name,
          args: UserSocialRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UserSocialRoute';

  static const _i33.PageInfo<UserSocialRouteArgs> page =
      _i33.PageInfo<UserSocialRouteArgs>(name);
}

class UserSocialRouteArgs {
  const UserSocialRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'UserSocialRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i32.UserPage]
class UserRoute extends _i33.PageRouteInfo<UserRouteArgs> {
  UserRoute({
    _i34.Key? key,
    required String name,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          UserRoute.name,
          args: UserRouteArgs(
            key: key,
            name: name,
          ),
          rawPathParams: {'name': name},
          initialChildren: children,
        );

  static const String name = 'UserRoute';

  static const _i33.PageInfo<UserRouteArgs> page =
      _i33.PageInfo<UserRouteArgs>(name);
}

class UserRouteArgs {
  const UserRouteArgs({
    this.key,
    required this.name,
  });

  final _i34.Key? key;

  final String name;

  @override
  String toString() {
    return 'UserRouteArgs{key: $key, name: $name}';
  }
}
