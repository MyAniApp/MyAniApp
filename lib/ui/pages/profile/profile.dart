import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:myaniapp_v2/constants.dart';
import 'package:myaniapp_v2/graphql/__generated/ui/pages/profile/profile.graphql.dart';
import 'package:myaniapp_v2/routes.gr.dart';
import 'package:myaniapp_v2/ui/common/graphql.dart';
import 'package:myaniapp_v2/ui/common/image.dart';
import 'package:myaniapp_v2/ui/common/markdown/markdown.dart';

@RoutePage()
class ProfilePage extends HookWidget {
  const ProfilePage({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    var hook = useQuery$User(
      Options$Query$User(
        variables: Variables$Query$User(name: name),
      ),
    );

    return Scaffold(
      appBar: hook.result.data == null ? AppBar() : null,
      body: Graphql(
        hook: hook,
        builder: (result) => NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 150,
              toolbarHeight: 0,
              // leadingWidth: 20,
              flexibleSpace: Header(user: result.User!),
            ),
          ],
          body: ListView(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            children: [
              if (result.User!.about?.isNotEmpty == true)
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withAlpha(150),
                    borderRadius: imageRadius,
                  ),
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: Markdown(data: result.User!.about!),
                ),
              const SizedBox(
                height: 10,
              ),
              if (result.User!.statistics?.anime != null)
                GestureDetector(
                  onTap: () => context.router
                      .push(ProfileAnimeListRoute(userId: result.User!.id)),
                  child: Stats(stats: result.User!.statistics!.anime),
                ),
              if (result.User!.statistics?.anime != null &&
                  result.User!.statistics?.manga != null)
                const SizedBox(height: 10),
              if (result.User!.statistics?.manga != null)
                GestureDetector(
                  onTap: () => context.router
                      .push(ProfileMangaListRoute(userId: result.User!.id)),
                  child: Stats(stats: result.User!.statistics!.manga),
                ),
              const SizedBox(
                height: 10,
              ),
              Genres(stats: result.User!.statistics!),
            ],
          ),
        ),
      ),
    );
  }
}

class Genres extends StatelessWidget {
  const Genres({super.key, required this.stats});

  final Query$User$User$statistics stats;

  List<Fragment$GenreStat> genres() {
    List<Fragment$GenreStat> genres = [];

    if (stats.anime?.genres?.isNotEmpty == true) {
      genres.addAll(stats.anime!.genres!.whereType<Fragment$GenreStat>());
    }
    if (stats.manga?.genres?.isNotEmpty == true) {
      if (genres.isNotEmpty) {
        for (var genre in stats.manga!.genres!) {
          if (genres.any((element) => element.genre == genre!.genre)) {
            var idx =
                genres.indexWhere((element) => element.genre == genre!.genre);

            genres[idx] =
                genres[idx].copyWith(count: genres[idx].count + genre!.count);
          } else {
            genres.add(genre!);
          }
        }
      } else {
        genres.addAll(stats.manga!.genres!.whereType<Fragment$GenreStat>());
      }
    }

    genres.sort(
      (a, b) => b.count.compareTo(a.count),
    );

    return genres.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    var genres = this.genres();
    return Column(
      children: [
        Text(
          'Genre Overview',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withAlpha(150),
            borderRadius: imageRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runSpacing: 10,
              spacing: 10,
              children: [
                for (var genre in genres)
                  Chip(
                    label: Column(
                      children: [
                        Text(genre.genre!),
                        Text(genre.count.toString()),
                      ],
                    ),
                    backgroundColor: Theme.of(context).hoverColor,
                    side: BorderSide.none,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Stats extends StatelessWidget {
  const Stats({super.key, required this.stats})
      : assert(stats is Query$User$User$statistics$anime ||
            stats is Query$User$User$statistics$manga);

  final dynamic stats;

  @override
  Widget build(BuildContext context) {
    String left;
    String middle;
    String right;
    var isAnime = stats is Query$User$User$statistics$anime;

    if (isAnime) {
      var s = stats as Query$User$User$statistics$anime;
      left = s.count.toString();
      middle = (s.minutesWatched / 1440).toStringAsFixed(1);
      right = s.meanScore.toStringAsFixed(1);
    } else {
      var s = stats as Query$User$User$statistics$manga;
      left = s.count.toString();
      middle = s.chaptersRead.toString();
      right = s.meanScore.toStringAsFixed(1);
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withAlpha(150),
        borderRadius: imageRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: DefaultTextStyle(
          style: const TextStyle(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runSpacing: 10,
            spacing: 10,
            children: [
              Column(
                children: [
                  Text(left),
                  Text(
                    'Total ${isAnime ? 'Anime' : 'Manga'}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(middle),
                  Text(
                    isAnime ? 'Days watched' : 'Chapters Read',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(right),
                  Text(
                    'Mean Score',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.user});

  final Query$User$User user;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return FlexibleSpaceBar(
      // collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Colors.transparent,
                theme.colorScheme.surface.withOpacity(0.4),
                theme.colorScheme.surface.withOpacity(0.6),
                theme.colorScheme.surface.withOpacity(1),
              ],
              stops: const [0, 0.3, 0.5, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds),
            blendMode: BlendMode.srcOver,
            child: user.bannerImage != null
                ? CImage(
                    viewer: true,
                    imageUrl: user.bannerImage!,
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                  )
                : Container(
                    height: 150,
                    color: Colors.grey,
                  ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  CImage(
                    height: 110,
                    width: 110,
                    imageUrl: user.avatar!.large!,
                    viewer: true,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.arrow_back),
              ),
              onPressed: () => context.router.pop(),
            ),
          ),
        ],
      ),
    );
  }
}
