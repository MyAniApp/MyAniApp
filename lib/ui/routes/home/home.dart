import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/providers/user/user.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/routes/home/drawer.dart';

@RoutePage()
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    logger.d([context.routeData.breadcrumbs, context.routeData.pathParams]);

    return user.when(
      data: (data) => AutoTabsRouter(
        routes: [
          const HomeOverviewRoute(),
          if (data != null) const HomeAnimeRoute(),
          if (data != null) const HomeMangaRoute(),
          const HomeActivitiesRoute(),
        ],
        builder: (context, child) {
          var router = AutoTabsRouter.of(context);

          return Scaffold(
            body: child,
            drawer: Drawer(
              child: ListView(
                children: [
                  if (data == null)
                    ElevatedButton(
                      onPressed: () => context.pushRoute(const LoginRoute()),
                      child: const Text('Login'),
                    )
                  else
                    ElevatedButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const LogoutDialog(),
                      ),
                      child: const Text('Logout'),
                    ),
                ],
              ),
            ),
            // appBar: AppBar(),
            bottomNavigationBar: BottomNavigationBar(
              onTap: router.setActiveIndex,
              currentIndex: router.activeIndex,
              type: BottomNavigationBarType.shifting,
              fixedColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Theme.of(context).colorScheme.secondary,
              showUnselectedLabels: false,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "home",
                ),
                if (data != null)
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.local_movies),
                    label: "Anime",
                  ),
                if (data != null)
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    label: "Manga",
                  ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble),
                  label: "Activity",
                ),
              ],
            ),
          );
        },
      ),
      error: (error, stackTrace) =>
          GraphqlError(exception: error as OperationException),
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
