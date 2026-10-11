import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:markdown/markdown.dart" as md2;
import 'package:myaniapp/common/markdown/generator/center.dart';
import 'package:myaniapp/common/markdown/generator/image.dart';
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
  List<md2.InlineSyntax> inlineSyntaxNoHtml,
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
  inlineSyntaxNoHtml: [
    SpoilerSyntax(),
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
    // wrap error most likely from html parsing...
    if (body) {
      return MarkdownErrorBoundary(
        fallback: () => Padding(
          padding: padding,
          child: md3.MarkdownBody(
            data: data,
            selectable: selectable ?? false,
            shrinkWrap: shrinkWrap ?? false,
            styleSheet: md3.MarkdownStyleSheet.fromTheme(Theme.of(context)),
            extensionSet: markdownConfig.extensionSet,
            inlineSyntaxes: markdownConfig.inlineSyntaxNoHtml,
            blockSyntaxes: [...markdownConfig.blockSyntax],
            builders: {...markdownConfig.builders, 'img': ImageBuilder()},
            withDefaultBlockSyntaxes: false,
            withDefaultInlineSyntaxes: false,
            onTapLink: (text, href, title) =>
                onTapLink(context, text, href, title),
          ),
        ),
        child: Padding(
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
        ),
      );
    }
    return MarkdownErrorBoundary(
      fallback: () => md3.Markdown(
        data: data,
        selectable: selectable ?? false,
        shrinkWrap: shrinkWrap ?? false,
        padding: padding,
        noScroll: body,
        styleSheet: md3.MarkdownStyleSheet.fromTheme(Theme.of(context)),
        extensionSet: markdownConfig.extensionSet,
        inlineSyntaxes: markdownConfig.inlineSyntaxNoHtml,
        blockSyntaxes: [...markdownConfig.blockSyntax],
        builders: {...markdownConfig.builders, 'img': ImageBuilder()},
        withDefaultBlockSyntaxes: false,
        withDefaultInlineSyntaxes: false,
        onTapLink: (text, href, title) => onTapLink(context, text, href, title),
      ),
      child: md3.Markdown(
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
      ),
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

class MarkdownErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function() fallback;
  const MarkdownErrorBoundary({
    super.key,
    required this.child,
    required this.fallback,
  });

  @override
  State<MarkdownErrorBoundary> createState() => _MarkdownErrorBoundaryState();
}

class _MarkdownErrorBoundaryState extends State<MarkdownErrorBoundary> {
  final Widget Function(FlutterErrorDetails) _originalBuilder =
      ErrorWidget.builder;

  @override
  void initState() {
    super.initState();
    ErrorWidget.builder = (FlutterErrorDetails details) {
      if (mounted) {
        // setState(() {
        //   _hasError = true;
        //   _errorLog = details.exceptionAsString();
        // });
        return widget.fallback();
      }
      return _originalBuilder(details);
    };
  }

  @override
  void dispose() {
    ErrorWidget.builder = _originalBuilder;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
