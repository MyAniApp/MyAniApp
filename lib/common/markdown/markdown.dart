import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:markdown/markdown.dart" as md2;
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/markdown/generator/center.dart';
import 'package:myaniapp/common/markdown/generator/image.dart';
import 'package:myaniapp/common/markdown/generator/media_card.dart';
import 'package:myaniapp/common/markdown/generator/spoiler.dart';
import 'package:myaniapp/common/markdown/syntax/center.dart';
import 'package:myaniapp/common/markdown/syntax/heading.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart' as md3;
import 'package:myaniapp/common/markdown/syntax/html.dart';
import 'package:myaniapp/common/markdown/syntax/user_mention.dart';
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
  List<md2.BlockSyntax>.unmodifiable(<md2.BlockSyntax>[
    const md2.TableSyntax(),
    const md2.UnorderedListWithCheckboxSyntax(),
    const md2.OrderedListWithCheckboxSyntax(),
    const md2.FootnoteDefSyntax(),
  ]),
  List<md2.InlineSyntax>.unmodifiable(<md2.InlineSyntax>[
    // md2.InlineHtmlSyntax(),
    md2.StrikethroughSyntax(),
    md2.AutolinkExtensionSyntax(),
  ]),
);

({
  md2.ExtensionSet extensionSet,
  List<md2.InlineSyntax> inlineSynyax,
  List<md2.BlockSyntax> blockSyntax,
  Map<String, md3.MarkdownElementBuilder> builders,
})
markdownConfig = (
  extensionSet: md2.ExtensionSet(
    List<md2.BlockSyntax>.unmodifiable(<md2.BlockSyntax>[
      const md2.TableSyntax(),
      const md2.UnorderedListWithCheckboxSyntax(),
      const md2.OrderedListWithCheckboxSyntax(),
      const md2.FootnoteDefSyntax(),
    ]),
    List<md2.InlineSyntax>.unmodifiable(<md2.InlineSyntax>[
      // md2.InlineHtmlSyntax(),
      md2.StrikethroughSyntax(),
      md2.AutolinkExtensionSyntax(),
      md2.LinkSyntax(),
    ]),
  ),
  inlineSynyax: [
    SpoilerSyntax(),
    HTMLInlineSynyax(),
    CenterInlineSyntax(),
    AnilistImageSyntax(),
    // EmbedMediaCardSyntax(),
    UserMentionSyntax(),
    md2.EmailAutolinkSyntax(),
    md2.AutolinkSyntax(),
    md2.LineBreakSyntax(),
    md2.EmphasisSyntax.asterisk(),
    md2.EmphasisSyntax.underscore(),
    md2.CodeSyntax(),
    md2.ImageSyntax(),
    md2.SoftLineBreakSyntax(),
  ],
  blockSyntax: [
    CustomHeaderSyntax(),
    // HTMLBlockSyntax(),
    const md2.EmptyBlockSyntax(),
    const md2.SetextHeaderSyntax(),
    const md2.HeaderSyntax(),
    const md2.CodeBlockSyntax(),
    const md2.BlockquoteSyntax(),
    const md2.HorizontalRuleSyntax(),
    const md2.UnorderedListSyntax(),
    const md2.OrderedListSyntax(),
    const md2.LinkReferenceDefinitionSyntax(),
    const md2.ParagraphSyntax(),
  ],
  builders: {'center': CenterNode(), 'spoiler': SpoilerBuilder()},
);

// var markdownConfig = md.MarkdownConfig(
//   configs: [
//     const md.PConfig(textStyle: TextStyle()),
//     CustomH1Config(),
//     CustomH2Config(),
//     CustomH3Config(),
//     const md.PreConfig(decoration: BoxDecoration()),
//     const md.CodeConfig(style: TextStyle()),
//     md.ImgConfig(builder: (url, attributes) => CachedImage(url)),
//     md.LinkConfig(
//       style: const TextStyle(color: Colors.blue),
//       onTap: (value) {
//         var uri = Uri.tryParse(value);
//         if (uri?.host == 'anilist.co') {
//           try {
//             var context = goRouter.configuration.navigatorKey.currentContext!;
//             if (['anime', 'manga'].contains(uri!.pathSegments.first)) {
//               context.push(Routes.media(int.parse(uri.pathSegments[1])));
//               return;
//             } else if ([
//               'character',
//               'staff',
//             ].contains(uri.pathSegments.first)) {
//               if (uri.pathSegments[1] == "staff") {
//                 context.push(Routes.staff(int.parse(uri.pathSegments[1])));
//               } else {
//                 context.push(Routes.character(int.parse(uri.pathSegments[1])));
//               }
//               return;
//             } else if (uri.pathSegments.first == 'forum' &&
//                 uri.pathSegments[1] == 'thread') {
//               // print(uri.pathSegments);
//               if (uri.pathSegments.length == 5) {
//                 context.push(
//                   Routes.threadComment(
//                     int.parse(uri.pathSegments[2]),
//                     int.parse(uri.pathSegments[4]),
//                   ),
//                 );
//               } else {
//                 context.push(Routes.thread(int.parse(uri.pathSegments.last)));
//               }
//               return;
//             } else if (uri.pathSegments.first == 'activity') {
//               context.push(Routes.activity(int.parse(uri.pathSegments[1])));
//               return;
//             }
//           } catch (err) {}
//         }
//         if (uri != null) {
//           launchUrl(uri, mode: LaunchMode.externalApplication);
//         }
//       },
//     ),
//   ],
// );
// var markdownGenerator = md.MarkdownGenerator(
//   linesMargin: const EdgeInsets.all(0),
//   extensionSet: extensionSet,
//   generators: [
//     linkGenerator,
//     // centerGenerator,
//     mediaCardGenerator,
//     imageGenerator,
//     spoilerGenerator,
//     hrGenerator,
//     bGenerator,
//     iGenerator,
//   ],
//   inlineSyntaxList: [
//     CenterInlineSyntax(),
//     // AnilistImageSyntax(),
//     SpoilerSyntax(),
//     EmbedMediaCardSyntax(),
//   ],
//   blockSyntaxList: [CustomHeaderSyntax()],
//   // textGenerator: (node, config, visitor) =>
//   //     CustomTextNode(node.textContent, config, visitor),
// );

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
    // print(htmlToMarkdown(data));

    if (body) {
      return Padding(
        padding: padding,
        child: md3.MarkdownBody(
          data: data,
          selectable: selectable ?? false,
          shrinkWrap: shrinkWrap ?? false,
          styleSheet: md3.MarkdownStyleSheet.fromTheme(Theme.of(context)),
          extensionSet: markdownConfig.extensionSet,
          inlineSyntaxes: markdownConfig.inlineSynyax,
          blockSyntaxes: [...markdownConfig.blockSyntax],
          builders: {...markdownConfig.builders, 'img': ImageBuilder()},
          withDefaultBlockSyntaxes: false,
          withDefaultInlineSyntaxes: false,
          onTapLink: (text, href, title) =>
              onTapLink(context, text, href, title),
        ),
      );
    }
    return md3.Markdown(
      // data: htmlToMarkdown(data),
      data: data,
      selectable: selectable ?? false,
      shrinkWrap: shrinkWrap ?? false,
      padding: padding,
      noScroll: body,
      styleSheet: md3.MarkdownStyleSheet.fromTheme(Theme.of(context)),
      extensionSet: markdownConfig.extensionSet,
      inlineSyntaxes: markdownConfig.inlineSynyax,
      blockSyntaxes: [...markdownConfig.blockSyntax],
      builders: {...markdownConfig.builders, 'img': ImageBuilder()},
      withDefaultBlockSyntaxes: false,
      withDefaultInlineSyntaxes: false,
      onTapLink: (text, href, title) => onTapLink(context, text, href, title),
    );
  }

  void onTapLink(
    BuildContext context,
    String text,
    String? href,
    String title,
  ) {
    if (href == null) return;
    var uri = Uri.tryParse(href);
    if (uri?.host == 'anilist.co') {
      try {
        if (['anime', 'manga'].contains(uri!.pathSegments.first)) {
          context.push(Routes.media(int.parse(uri.pathSegments[1])));
          return;
        } else if ([
          'character',
          'staff',
          'user',
        ].contains(uri.pathSegments.first)) {
          if (uri.pathSegments[1] == "staff") {
            context.push(Routes.staff(int.parse(uri.pathSegments[1])));
          } else if (uri.pathSegments[1] == 'character') {
            context.push(Routes.character(int.parse(uri.pathSegments[1])));
          } else {
            context.push(Routes.user(uri.pathSegments[1]));
          }
          return;
        } else if (uri.pathSegments.first == 'forum' &&
            uri.pathSegments[1] == 'thread') {
          // print(uri.pathSegments);
          if (uri.pathSegments.length == 5) {
            context.push(
              Routes.threadComment(
                int.parse(uri.pathSegments[2]),
                int.parse(uri.pathSegments[4]),
              ),
            );
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
  }
}

class ColorTagBuilder extends md3.MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md2.Element element, TextStyle? preferredStyle) {
    return Text(
      element.textContent,
      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    );
  }
}

// class CustomH1Config extends md.H1Config {
//   @override
//   md.HeadingDivider? get divider => null;
// }

// class CustomH2Config extends md.H2Config {
//   @override
//   md.HeadingDivider? get divider => null;
// }

// class CustomH3Config extends md.H3Config {
//   @override
//   md.HeadingDivider? get divider => null;
// }

// class CustomTextNode extends md.ElementNode {
//   final String text;
//   final md.MarkdownConfig config;
//   final md.WidgetVisitor visitor;

//   CustomTextNode(this.text, this.config, this.visitor);

//   @override
//   void onAccepted(SpanNode parent) {
//     final textStyle = config.p.textStyle.merge(parentStyle);
//     children.clear();
//     // print(text);
//     if (!text.contains(htmlRep)) {
//       accept(TextNode(text: text, style: textStyle));
//       return;
//     }
//     final spans = parseHtml(
//       md2.Text(text),
//       visitor: md.WidgetVisitor(
//         config: visitor.config,
//         generators: visitor.generators,
//         richTextBuilder: visitor.richTextBuilder,
//       ),
//       parentStyle: parentStyle,
//     );
//     for (var element in spans) {
//       accept(element);
//     }
//   }
// }
