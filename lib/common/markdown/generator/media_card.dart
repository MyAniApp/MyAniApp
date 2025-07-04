import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:markdown_widget/markdown_widget.dart' as md;
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/gql_widget.dart';
import 'package:myaniapp/common/ink_well_image.dart';
import 'package:myaniapp/common/markdown/generator/link.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/show.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/media_card.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/providers/settings.dart';
import 'package:myaniapp/routes.dart';
import 'package:mygraphql/graphql.dart';

md.SpanNodeGeneratorWithTag mediaCardGenerator = md.SpanNodeGeneratorWithTag(
  tag: "mediaCard",
  generator: (e, config, visitor) =>
      MediaCardNode(e.attributes, config.p, config.a),
);

class EmbedMediaCardSyntax extends m.InlineSyntax {
  EmbedMediaCardSyntax()
      : super(r"https:\/\/anilist\.co\/(?:anime|manga)\/(\d+)\/.*?(?:\/|\s)");

  @override
  bool onMatch(m.InlineParser parser, Match match) {
    var mediaId = match.group(1);

    if (mediaId != null && int.tryParse(mediaId) != null) {
      m.Element el = m.Element("mediaCard", []);
      el.attributes["id"] = mediaId;
      el.attributes["href"] = match.input.substring(match.start, match.end);
      parser.addNode(el);
    }

    return true;
  }
}

class MediaCardNode extends md.ElementNode {
  final Map<String, String> attributes;
  final md.PConfig pConfig;
  final md.LinkConfig linkConfig;

  MediaCardNode(this.attributes, this.pConfig, this.linkConfig);

  @override
  TextStyle get style =>
      parentStyle?.merge(pConfig.textStyle) ?? pConfig.textStyle;

  @override
  InlineSpan build() {
    var id = int.parse(attributes['id']!);

    return WidgetSpan(
      child: MediaCard(
        id: id,
        href: attributes['href']!,
        linkConfig: linkConfig,
      ),
    );
  }
}

class MediaCard extends ConsumerWidget {
  const MediaCard({
    super.key,
    required this.id,
    required this.href,
    required this.linkConfig,
  });

  final int id;
  final String href;
  final md.LinkConfig linkConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var showEmbedMediaCard =
        ref.watch(settingsProvider.select((value) => value.showEmbedMediaCard));

    return Show(
      when: showEmbedMediaCard,
      fallback: Text.rich((LinkNode({'href': href}, linkConfig)
            ..accept(md.TextNode(text: href)))
          .build()),
      child: () => HookBuilder(
        builder: (context) {
          var (:snapshot, :fetchMore, :refetch) = c.useQuery(GQLRequest(
            embedMediaCardQuery,
            variables: Variables$Query$EmbedMediaCard(id: id).toJson(),
            parseData: Query$EmbedMediaCard.fromJson,
          ));

          return GQLWidget(
            refetch: refetch,
            response: snapshot,
            builder: () => Card.outlined(
              child: InkWellImage(
                onTap: () => context.push(Routes.media(id),
                    extra: {"placeholder": snapshot.parsedData!.Media}),
                onLongPress: () =>
                    MediaSheet.show(context, snapshot.parsedData!.Media!),
                borderRadius: imageRadius,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 70,
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: imageRadius.topLeft,
                            bottomLeft: imageRadius.bottomLeft,
                          ),
                          child: CachedImage(
                            snapshot.parsedData!.Media!.coverImage!.extraLarge!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.parsedData!.Media!.title!.userPreferred!,
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            if (snapshot.parsedData!.Media!.format != null)
                              Text(
                                snapshot.parsedData!.Media!.format!.name
                                    .capitalize(),
                                maxLines: 1,
                              )
                            else
                              Text(
                                snapshot.parsedData!.Media!.type!.name
                                    .capitalize(),
                                maxLines: 1,
                              ),
                            if (snapshot
                                    .parsedData!.Media!.genres?.isNotEmpty ==
                                true)
                              Text(
                                snapshot.parsedData!.Media!.genres!.join(", "),
                                maxLines: 1,
                              )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
