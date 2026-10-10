import 'package:flutter/gestures.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart'
    show MarkdownElementBuilder;
import 'package:material_ui/material_ui.dart';
import "package:markdown/markdown.dart" as md;
import 'package:myaniapp/common/markdown/markdown.dart';
import 'package:myaniapp/routes.dart';

class SpoilerSyntax extends md.InlineSyntax {
  SpoilerSyntax() : super(r"~!([^]*?)!~");

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    var spoiler = match.group(1);

    if (spoiler != null) {
      md.Element el = md.Element.text("spoiler", spoiler);
      parser.addNode(el);
    }

    return true;
  }
}

class SpoilerBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    return RichText(
      text: TextSpan(
        text: "[Spoiler]",
        style: (preferredStyle ?? TextStyle()).copyWith(color: Colors.blue),
        recognizer: TapGestureRecognizer()
          ..onTap = () => showDialog(
            context: goRouter.configuration.navigatorKey.currentContext!,
            builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 50,
                ),
                child: MarkdownWidget(
                  data: element.textContent,
                  shrinkWrap: true,
                ),
              ),
            ),
          ),
      ),
    );
  }
}
