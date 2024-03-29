import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__generated__/media.data.gql.dart';
import 'package:myaniapp/graphql/__generated__/schema.schema.gql.dart';
import 'package:myaniapp/providers/media.dart';
import 'package:myaniapp/ui/common/image.dart';
import 'package:myaniapp/ui/common/markdown/markdown.dart';
import 'package:myaniapp/ui/common/widget_gradient.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MediaOverviewPage extends ConsumerWidget {
  const MediaOverviewPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var media = ref.watch(mediaProvider(id));

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        if (media.value!.genres?.isNotEmpty == true)
          Genres(genres: media.value!.genres!),
        if (media.value!.description != null)
          Description(media.value!.description),
        const SizedBox(
          height: 10,
        ),
        _InfoSection(
          media: media.value!,
        ),
        const SizedBox(
          height: 10,
        ),
        _Tags(tags: media.value!.tags!),
        if (media.value!.trailer != null &&
            (kIsWeb || Platform.isAndroid || Platform.isIOS))
          const Player()
        else if (media.value!.trailer != null)
          Trailer(trailer: media.value!.trailer!),
        const SizedBox(
          height: 10,
        ),
        if (media.value!.externalLinks?.isNotEmpty == true)
          _Links(media: media.value!),
      ],
    );
  }
}

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    if (!(kIsWeb || Platform.isAndroid)) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trailer', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(
          height: 10,
        ),
        YoutubePlayer(controller: context.ytController),
      ],
    );
  }
}

class Trailer extends StatelessWidget {
  const Trailer({super.key, required this.trailer});

  final GMediaData_Media_trailer trailer;

  @override
  Widget build(BuildContext context) {
    if (trailer.site != "youtube" && trailer.site != "dailymotion") {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trailer',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 500),
          child: InkWell(
            onTap: () => launchUrlString(trailer.site! == "youtube"
                ? "https://youtube.com/watch?v=${trailer.id}"
                : "https://www.dailymotion.com/video/${trailer.id}"),
            child: Stack(
              alignment: Alignment.center,
              children: [
                WidgetGradient(child: CImage(imageUrl: trailer.thumbnail!)),
                Text(
                  "Click to Watch",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Genres extends StatelessWidget {
  const Genres({
    super.key,
    required this.genres,
  });

  final BuiltList<String?> genres;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: genres
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ActionChip(
                    label: Text(e!),
                    onPressed: () => context.push('/search?genre=$e'),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.media,
  });

  final GMediaData_Media media;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(),
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      child: GridView(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          if (media.format != null)
            InfoCard(title: 'Format', info: media.format!.name.capitalize()),
          if (media.startDate?.toDateString() != null)
            InfoCard(
              title: media.status == GMediaStatus.NOT_YET_RELEASED ||
                      media.status == GMediaStatus.RELEASING
                  ? media.type == GMediaType.ANIME
                      ? 'Airing'
                      : 'Releasing'
                  : media.type == GMediaType.ANIME
                      ? 'Aired'
                      : 'Released',
              info:
                  '${media.startDate?.toDateString() ?? '?'} -\n${media.endDate?.toDateString() ?? '?'}',
            ),
          if (media.season != null)
            InfoCard(
              title: 'Season',
              info:
                  '${media.season!.name.capitalize()}${media.seasonYear != null ? ' ${media.seasonYear}' : ''}',
            ),
          if (media.episodes != null)
            InfoCard(
              title: 'Episodes',
              info: media.episodes?.toString() ?? 'Unknown',
            ),
          if (media.duration != null)
            InfoCard(
              title: 'Duration',
              info: '${media.duration} mins',
            ),
          if (media.chapters != null)
            InfoCard(
              title: 'Chapters',
              info: media.chapters.toString(),
            ),
          if (media.volumes != null)
            InfoCard(
              title: 'Volumes',
              info: media.volumes.toString(),
            ),
          InfoCard(
            title: 'Status',
            info: media.status!.name.capitalize(),
          ),
          if (media.studios?.nodes?.isNotEmpty == true)
            InfoCard(
              title: 'Studios',
              info: media.studios!.nodes!.map((n) => n!.name).join(', '),
            ),
          if (media.source != null)
            InfoCard(
              title: 'Source',
              info: media.source!.name.capitalize(),
            ),
          if (media.hashtag != null)
            InfoCard(
              title: 'Hashtag',
              info: media.hashtag!,
              onTap: () => launchUrlString(
                  'https://twitter.com/search?q=${Uri.encodeComponent(media.hashtag!)}&src=typd'),
            ),
        ],
      ),
    );
  }
}

class _Tags extends StatefulWidget {
  const _Tags({
    required this.tags,
  });

  final BuiltList<GMediaData_Media_tags?> tags;

  @override
  State<_Tags> createState() => _TagsState();
}

class _TagsState extends State<_Tags> {
  bool showSpoilers = false;

  @override
  Widget build(BuildContext context) {
    var shown = showSpoilers
        ? widget.tags
        : widget.tags.where((e) => e!.isMediaSpoiler == false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Tags', style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            if (widget.tags.any((element) => element!.isMediaSpoiler == true))
              TextButton(
                onPressed: () => setState(() => showSpoilers = !showSpoilers),
                child: Text('${showSpoilers ? 'Hide' : 'Show'} Spoilers'),
              ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: shown
              .map(
                (e) => _Tag(
                  tag: e!,
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.tag,
  });

  final GMediaData_Media_tags tag;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: tag.isMediaSpoiler == true
                ? Theme.of(context).colorScheme.error
                : null,
          ),
      overflow: TextOverflow.ellipsis,
      child: InkWell(
        onTap: () => context.push('/search?withTags=${tag.name}'),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withAlpha(150),
            borderRadius: imageRadius,
          ),
          constraints: BoxConstraints(
              maxWidth: (MediaQuery.of(context).size.width - 26) / 2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(tag.name),
                ),
                Text('${tag.rank}%')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.info,
    this.onTap,
  });

  final String info;
  final VoidCallback? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    onTap;
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withAlpha(150),
        borderRadius: imageRadius,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  info,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description(
    this.description, {
    super.key,
    this.height = 150,
  });

  final String? description;
  final double height;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(maxHeight: height),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withAlpha(150),
        borderRadius: imageRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Markdown(data: description ?? '*No Description*'),
      ),
    );
  }
}

class _Links extends StatelessWidget {
  const _Links({
    required this.media,
  });

  final GMediaData_Media media;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Links',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var link in media.externalLinks!) _Link(link: link!),
          ],
        ),
      ],
    );
  }
}

class _Link extends StatelessWidget {
  const _Link({
    required this.link,
  });

  final GMediaData_Media_externalLinks link;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (link.isDisabled == true || link.url == null)
          ? null
          : () => launchUrlString(link.url!),
      style: ButtonStyle(
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        foregroundColor: MaterialStatePropertyAll<Color>(
          Theme.of(context).textTheme.titleMedium!.color!,
        ),
        backgroundColor: MaterialStatePropertyAll<Color>(
          Theme.of(context).colorScheme.surfaceVariant.withAlpha(150),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (link.icon != null)
            SizedBox(
              height: 20,
              width: 20,
              child: CImage(
                imageUrl: link.icon!,
                color:
                    link.color != null ? HexColor.fromHex(link.color!) : null,
              ),
            ),
          const SizedBox(
            width: 5,
          ),
          Text(link.site),
        ],
      ),
    );
  }
}
