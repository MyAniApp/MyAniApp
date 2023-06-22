import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/media/media.graphql.dart';
import 'package:myaniapp/providers/media.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/image.dart';

@RoutePage()
class MediaPage extends ConsumerWidget {
  const MediaPage({super.key, @PathParam('id') required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var media = ref.watch(mediaProvider(id));
    // return AutoTabsScaffold(routes: routes)

    return Scaffold(
      body: AutoTabsRouter.tabBar(
        routes: [
          MediaOverviewRoute(),
          if ((media.value?.relations?.edges?.length ?? 0) > 0)
            MediaRelationsRoute(),
          if ((media.value?.recommendations?.nodes?.length ?? 0) > 0)
            MediaSimilarRoute(),
          if ((media.value?.reviews?.nodes?.length ?? 0) > 0)
            MediaReviewsRoute(),
          if ((media.value?.characters?.nodes?.length ?? 0) > 0)
            MediaCharactersRoute(),
          if ((media.value?.staff?.nodes?.length ?? 0) > 0) MediaStaffRoute(),
          MediaSocialRoute()
        ],
        builder: (context, child, tabController) => media.when(
          data: (media) => NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              MediaAppBar(media: media, controller: tabController),
            ],
            body: child,
          ),
          error: (error, stackTrace) => Scaffold(
            appBar: AppBar(),
            body: GraphqlError(exception: error as OperationException),
          ),
          loading: () => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ),
    );
  }
}

class MediaAppBar extends StatelessWidget {
  const MediaAppBar({
    super.key,
    required this.media,
    required this.controller,
  });

  final Query$Media$Media media;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 255,
      bottom: TabBar(
        isScrollable: true,
        tabs: [
          const Tab(
            text: 'Overview',
          ),
          if ((media.relations?.edges?.length ?? 0) > 0)
            const Tab(
              text: 'Relations',
            ),
          if ((media.recommendations?.nodes?.length ?? 0) > 0)
            const Tab(text: 'Similar'),
          if ((media.reviews?.nodes?.length ?? 0) > 0)
            const Tab(text: 'Reviews'),
          if ((media.characters?.nodes?.length ?? 0) > 0)
            const Tab(text: 'Characters'),
          if ((media.staff?.nodes?.length ?? 0) > 0)
            const Tab(
              text: 'Staff',
            ),
          const Tab(text: 'Social'),
        ],
        controller: controller,
      ),
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.blurBackground],
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
              child: media.bannerImage != null
                  ? CImage(
                      imageUrl: media.bannerImage!,
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
              padding: const EdgeInsets.only(left: 8.0, top: 50),
              child: SizedBox(
                width: 100,
                height: 150,
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: ClipRRect(
                    borderRadius: imageRadius,
                    child: CImage(
                      imageUrl: media.coverImage!.extraLarge!,
                      viewer: true,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 155, left: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SelectableText.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Original: ${media.title!.native!}',
                                ),
                                if (media.title!.romaji != null)
                                  TextSpan(
                                    text: '\nRomaji: ${media.title!.romaji}',
                                  ),
                                if (media.title!.english != null)
                                  TextSpan(
                                    text: '\nEnglish: ${media.title!.english}',
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      media.title!.userPreferred!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 20,
                      ),
                      Text((media.favourites ?? 0).toString()),
                      const SizedBox(
                        width: 10,
                      ),
                      if (media.averageScore != null) ...[
                        const Icon(
                          Icons.star,
                          size: 20,
                        ),
                        Text('${media.averageScore ?? 0}/100'),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
