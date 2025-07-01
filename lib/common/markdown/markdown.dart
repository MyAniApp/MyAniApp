import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:markdown/markdown.dart" as md2;
import 'package:markdown_widget/markdown_widget.dart' as md;
import 'package:markdown_widget/widget/span_node.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/markdown/generator/b.dart';
import 'package:myaniapp/common/markdown/generator/center.dart';
import 'package:myaniapp/common/markdown/generator/hr.dart';
import 'package:myaniapp/common/markdown/generator/html.dart';
import 'package:myaniapp/common/markdown/generator/i.dart';
import 'package:myaniapp/common/markdown/generator/image.dart';
import 'package:myaniapp/common/markdown/generator/link.dart';
import 'package:myaniapp/common/markdown/generator/media_card.dart';
import 'package:myaniapp/common/markdown/generator/spoiler.dart';
import 'package:myaniapp/common/markdown/syntax/center.dart';
import 'package:myaniapp/common/markdown/syntax/heading.dart';
import 'package:myaniapp/providers/settings.dart';
import 'package:myaniapp/routes.dart';
import 'package:url_launcher/url_launcher.dart';

RegExp removeFromMarkdown = RegExp("~~~|```");

String stripHTML(String data) {
  return data;
  // .replaceAll(removeFromMarkdown, "")
  // .replaceAll(RegExp(r"</?(B|b)>"), "**")
  // .replaceAll(RegExp("</?(i|I)>"), "*")
  // .replaceAllMapped(
  //   RegExp(r"youtube\((.*?)\)", dotAll: true),
  //   (match) => match.group(1) ?? '',
  // )
  // .replaceAll(removeFromMarkdown, "");
}

md2.ExtensionSet extensionSet = md2.ExtensionSet(
  List<md2.BlockSyntax>.unmodifiable(
    <md2.BlockSyntax>[
      const md2.TableSyntax(),
      const md2.UnorderedListWithCheckboxSyntax(),
      const md2.OrderedListWithCheckboxSyntax(),
      const md2.FootnoteDefSyntax(),
    ],
  ),
  List<md2.InlineSyntax>.unmodifiable(
    <md2.InlineSyntax>[
      // md2.InlineHtmlSyntax(),
      md2.StrikethroughSyntax(),
      md2.AutolinkExtensionSyntax()
    ],
  ),
);

var markdownConfig = md.MarkdownConfig(
  configs: [
    const md.PConfig(
      textStyle: TextStyle(),
    ),
    CustomH1Config(),
    CustomH2Config(),
    CustomH3Config(),
    const md.PreConfig(decoration: BoxDecoration()),
    const md.CodeConfig(
      style: TextStyle(),
    ),
    md.ImgConfig(
      builder: (url, attributes) => CachedImage(url),
    ),
    md.LinkConfig(
      style: const TextStyle(color: Colors.blue),
      onTap: (value) {
        var uri = Uri.tryParse(value);
        // print(uri?.host);
        if (uri?.host == 'anilist.co') {
          try {
            var context = goRouter.configuration.navigatorKey!.currentContext!;
            if (['anime', 'manga'].contains(uri!.pathSegments.first)) {
              context.push(Routes.media(int.parse(uri.pathSegments[1])));
              return;
            } else if (['character', 'staff']
                .contains(uri.pathSegments.first)) {
              if (uri.pathSegments[1] == "staff") {
                context.push(Routes.staff(int.parse(uri.queryParameters[1]!)));
              } else {
                context
                    .push(Routes.character(int.parse(uri.queryParameters[1]!)));
              }
              return;
            } else if (uri.pathSegments.first == 'forum' &&
                uri.pathSegments[1] == 'thread') {
              // print(uri.pathSegments);
              if (uri.pathSegments.length == 5) {
                print(Routes.threadComment(
                  int.parse(uri.pathSegments[2]),
                  int.parse(uri.pathSegments[4]),
                ));
                context.push(Routes.threadComment(
                  int.parse(uri.pathSegments[2]),
                  int.parse(uri.pathSegments[4]),
                ));
              } else {
                context.push(Routes.thread(int.parse(uri.pathSegments.last)));
              }
              return;
            } else if (uri.pathSegments.first == 'activity') {
              context.push(Routes.activity(int.parse(uri.pathSegments[1])));
              return;
            }
          } catch (err) {}
        }
        if (uri != null) {
          launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    ),
  ],
);
var markdownGenerator = md.MarkdownGenerator(
  linesMargin: const EdgeInsets.all(0),
  extensionSet: extensionSet,
  generators: [
    linkGenerator,
    centerGenerator,
    mediaCardGenerator,
    imageGenerator,
    spoilerGenerator,
    hrGenerator,
    bGenerator,
    iGenerator,
  ],
  inlineSyntaxList: [
    CenterInlineSyntax(),
    AnilistImageSyntax(),
    SpoilerSyntax(),
    EmbedMediaCardSyntax(),
  ],
  blockSyntaxList: [
    CustomHeaderSyntax(),
  ],
  textGenerator: (node, config, visitor) =>
      CustomTextNode(node.textContent, config, visitor),
);

class MarkdownWidget extends StatelessWidget {
  const MarkdownWidget({
    super.key,
    required this.data,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.body = false,
    this.selectable,
    this.shrinkWrap,
  });

  final String data;
  final bool body;
  final EdgeInsets padding;
  final bool? selectable;
  final bool? shrinkWrap;

  const MarkdownWidget.body({
    super.key,
    required this.data,
    this.body = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.selectable,
    this.shrinkWrap,
  });

  @override
  Widget build(BuildContext context) {
    if (body) {
      return Padding(
        padding: padding,
        child: md.MarkdownBlock(
          data: data,
          selectable: selectable ?? false,
          generator: markdownGenerator,
          config: markdownConfig,
        ),
      );
    }

    return md.MarkdownWidget(
      data: data,
      padding: padding,
      selectable: selectable ?? false,
      shrinkWrap: shrinkWrap ?? false,
      config: markdownConfig,
      markdownGenerator: markdownGenerator,
    );
  }
}

class CustomH1Config extends md.H1Config {
  @override
  md.HeadingDivider? get divider => null;
}

class CustomH2Config extends md.H2Config {
  @override
  md.HeadingDivider? get divider => null;
}

class CustomH3Config extends md.H3Config {
  @override
  md.HeadingDivider? get divider => null;
}

class CustomTextNode extends md.ElementNode {
  final String text;
  final md.MarkdownConfig config;
  final md.WidgetVisitor visitor;

  CustomTextNode(this.text, this.config, this.visitor);

  @override
  void onAccepted(SpanNode parent) {
    final textStyle = config.p.textStyle.merge(parentStyle);
    children.clear();
    // print(text);
    if (!text.contains(htmlRep)) {
      accept(TextNode(text: text, style: textStyle));
      return;
    }
    final spans = parseHtml(
      md2.Text(text),
      visitor: md.WidgetVisitor(
        config: visitor.config,
        generators: visitor.generators,
        richTextBuilder: visitor.richTextBuilder,
      ),
      parentStyle: parentStyle,
    );
    for (var element in spans) {
      accept(element);
    }
  }
}
