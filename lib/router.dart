import 'package:auto_route/auto_route.dart';
import 'package:myaniapp/router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          path: "/",
          guards: [OnboardGuard()],
          children: [
            AutoRoute(page: HomeLoggedInOverviewRoute.page, path: "home"),
            AutoRoute(page: HomeAnimeListRoute.page, path: "anime"),
            AutoRoute(page: ExploreRoute.page, path: "explore"),
            AutoRoute(page: HomeActivitiesRoute.page, path: "activities"),
            AutoRoute(page: ForumRoute.page, path: "forum/:tab"),
          ],
        ),
        AutoRoute(page: ActivityRoute.page, path: "/activity/:id"),
        AutoRoute(page: CalendarRoute.page, path: "/calendar"),
        AutoRoute(page: CharacterRoute.page, path: "/character/:id"),
        AutoRoute(page: ThreadRoute.page, path: "/forum/thread/:id"),
        AutoRoute(
            page: ThreadCommentRoute.page,
            path: "/thread/:id/comment/:commentId"),
        AutoRoute(
          page: LoginRoute.page,
          path: "/login",
        ),
        AutoRoute(page: TokenLoginRoute.page, path: "/login/token"),
        AutoRoute(page: AnilistLoginRoute.page, path: "/login/anilist"),
        AutoRoute(
          page: MediaRoute.page,
          path: "/media/:id",
          children: [
            // RedirectRoute(path: "", redirectTo: "info"),
            AutoRoute(page: MediaInfoRoute.page, path: "info"),
            AutoRoute(page: MediaRelationsRoute.page, path: "relations"),
            AutoRoute(page: MediaReviewsRoute.page, path: "reviews"),
            AutoRoute(page: MediaSimilarRoute.page, path: "similar"),
            AutoRoute(page: MediaCharactersRoute.page, path: "characters"),
            AutoRoute(page: MediaStaffRoute.page, path: "staff"),
            AutoRoute(page: MediaThreadsRoute.page, path: "threads"),
          ],
        ),
        AutoRoute(page: NotificationRoute.page, path: "/notifications"),
        AutoRoute(page: RecommendationsRoute.page, path: "/recommendations"),
        AutoRoute(page: ReviewRoute.page, path: "/review/:id"),
        AutoRoute(page: ReviewsRoute.page, path: "/reviews"),
        AutoRoute(page: SearchRoute.page, path: "/search/media"),
        AutoRoute(page: StaffSearchRoute.page, path: "/search/staff"),
        AutoRoute(page: SettingsRoute.page, path: "/settings"),
        AutoRoute(
          page: StaffRoute.page,
          path: "/staff/:id",
          children: [
            AutoRoute(page: StaffProductionRolesRoute.page, path: "production"),
            AutoRoute(page: StaffVARolesRoute.page, path: "voice")
          ],
        ),
        AutoRoute(page: StudioRoute.page, path: "/studio/:id"),
        AutoRoute(
          page: UserRoute.page,
          path: "/user/:name",
          children: [
            AutoRoute(page: UserInfoRoute.page, path: "info"),
            AutoRoute(page: UserActivityRoute.page, path: "activities"),
            AutoRoute(page: UserReviewsRoute.page, path: "reviews"),
            AutoRoute(page: UserSocialRoute.page, path: "social"),
            AutoRoute(page: UserThreadsRoute.page, path: "threads"),
          ],
        ),
        AutoRoute(page: UserAnimeRoute.page, path: "/user/:name/anime"),
        AutoRoute(page: UserMangaRoute.page, path: "/user/:name/manga"),
        AutoRoute(
            page: UserFavoritesRoute.page, path: "/user/:name/favorites/:tab"),
        AutoRoute(page: AuthRoute.page, path: "/auth")
      ];
}

// on first launch go to login page
class OnboardGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("seenOnboard")) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}

var router = AppRouter();
