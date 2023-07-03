import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:myaniapp/routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  AppRouter(this.ref);

  final WidgetRef ref;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MyHomeRoute.page,
          initial: true,
          children: [
            AutoRoute(page: HomeOverviewRoute.page, path: ''),
            AutoRoute(page: HomeAnimeRoute.page, path: 'anime'),
            AutoRoute(page: ExploreRoute.page, path: 'explore'),
            AutoRoute(page: HomeMangaRoute.page, path: 'manga'),
            AutoRoute(page: HomeActivitiesRoute.page, path: 'activities'),
          ],
        ),
        AutoRoute(page: AuthRoute.page, path: '/auth'),
        AutoRoute(
          page: MediaRoute.page,
          path: '/media/:id',
          children: [
            AutoRoute(page: MediaOverviewRoute.page, path: ''),
            AutoRoute(page: MediaRelationsRoute.page, path: 'relations'),
            AutoRoute(page: MediaSimilarRoute.page, path: 'similar'),
            AutoRoute(page: MediaReviewsRoute.page, path: 'reviews'),
            AutoRoute(page: MediaStaffRoute.page, path: 'staff'),
            AutoRoute(page: MediaCharactersRoute.page, path: 'characters'),
            AutoRoute(page: MediaSocialRoute.page, path: 'social')
          ],
        ),
        AutoRoute(page: ReviewRoute.page, path: '/review/:id'),
        AutoRoute(page: SearchRoute.page, path: '/search'),
        AutoRoute(page: ThreadRoute.page, path: '/thread/:id'),
        AutoRoute(page: ExploreRoute.page, path: '/explore'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: AniLoginRoute.page, path: '/login/anilist'),
        AutoRoute(page: TokenLoginRoute.page, path: '/login/token'),
        AutoRoute(page: ActivityRoute.page, path: '/activity/:id'),
        AutoRoute(page: CharacterRoute.page, path: '/character/:id'),
        AutoRoute(
          page: StaffRoute.page,
          path: '/staff/:id',
          children: [
            AutoRoute(page: StaffVoiceRoute.page, path: 'voice'),
            AutoRoute(page: StaffProductionRoute.page, path: 'production')
          ],
        ),
        AutoRoute(page: RecommendationsRoute.page, path: '/recommendations'),
        AutoRoute(
          page: UserRoute.page,
          path: '/user/:name',
          children: [
            AutoRoute(page: UserOverviewRoute.page, path: ''),
            AutoRoute(page: UserReviewsRoute.page, path: 'reviews'),
            AutoRoute(page: UserSocialRoute.page, path: 'social'),
            AutoRoute(page: UserActivityRoute.page, path: 'activity')
          ],
        ),
        AutoRoute(page: UserAnimeListRoute.page, path: '/user/:name/anime'),
        AutoRoute(page: UserMangaListRoute.page, path: '/user/:name/manga'),
        AutoRoute(page: NotificationsRoute.page, path: '/notifications')
      ];
}

late AppRouter appRouter;

class AuthLisener extends ChangeNotifier {
  AuthLisener(this.ref) {
    var user = ref.watch(userProvider);

    user.whenData((value) {
      if (value != null) notifyListeners();
    });

    // print('hii');
  }

  final WidgetRef ref;

  // void login() {
  //   _isLoggedIn = true;
  //   notifyListeners();
  // }

  // void logout() {
  //   _isLoggedIn = false;
  //   notifyListeners();
  // }
}

class MyObserver extends AutoRouterObserver {
  MyObserver(this.ref);

  final WidgetRef ref;

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    print('Tab route re-visited: ${route.name}');
    if (route.name == 'HomeAnimeRoute' &&
        ref.read(userProvider).value == null) {
      appRouter.navigate(const MyHomeRoute(children: [HomeOverviewRoute()]));
    }
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    print('Tab route visited: ${route.name}');
    if (route.name == 'HomeAnimeRoute' &&
        ref.read(userProvider).value == null) {
      appRouter.navigate(const MyHomeRoute(children: [HomeOverviewRoute()]));
    }
  }
}
