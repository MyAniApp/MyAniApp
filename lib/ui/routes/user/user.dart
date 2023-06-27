import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/user/user.graphql.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/image.dart';
import 'package:myaniapp/ui/routes/user/overview.dart';
import 'package:myaniapp/ui/routes/user/reviews/reviews.dart';

@RoutePage()
class UserPage extends StatelessWidget {
  const UserPage({super.key, @PathParam('name') required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Query$User$Widget(
      options: Options$Query$User(
        variables: Variables$Query$User(name: name),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading || !result.isConcrete) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (result.hasException) {
          return Scaffold(
            appBar: AppBar(),
            body: GraphqlError(exception: result.exception!),
          );
        }

        return Scaffold(
          body: AutoTabsRouter.tabBar(
            routes: [
              UserOverviewRoute(user: result.parsedData!.User!),
              UserReviewsRoute(userId: result.parsedData!.User!.id),
            ],
            builder: (context, child, tabController) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 235,
                  bottom: TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Colors.transparent,
                              theme.colorScheme.surface,
                            ],
                            stops: const [0, 1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds),
                          blendMode: BlendMode.srcOver,
                          child: result.parsedData!.User!.bannerImage != null
                              ? CImage(
                                  imageUrl:
                                      result.parsedData!.User!.bannerImage!,
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: double.maxFinite,
                                  viewer: true,
                                )
                              : Container(
                                  height: 150,
                                  color: Theme.of(context).disabledColor,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 85),
                          child: CImage(
                            imageUrl: result.parsedData!.User!.avatar!.large!,
                            height: 100,
                            width: 100,
                            viewer: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120, top: 160),
                          child: Text(
                            result.parsedData!.User!.name,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              body: child,
            ),
          ),
        );

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 235,
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Overview'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Colors.transparent,
                              theme.colorScheme.surface,
                            ],
                            stops: const [0, 1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(bounds),
                          blendMode: BlendMode.srcOver,
                          child: result.parsedData!.User!.bannerImage != null
                              ? CImage(
                                  imageUrl:
                                      result.parsedData!.User!.bannerImage!,
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: double.maxFinite,
                                  viewer: true,
                                )
                              : Container(
                                  height: 150,
                                  color: Theme.of(context).disabledColor,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 85),
                          child: CImage(
                            imageUrl: result.parsedData!.User!.avatar!.large!,
                            height: 100,
                            width: 100,
                            viewer: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120, top: 160),
                          child: Text(
                            result.parsedData!.User!.name,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                children: [
                  UserOverviewPage(user: result.parsedData!.User!),
                  UserReviewsPage(userId: result.parsedData!.User!.id),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
