import 'package:flutter_markdown_plus/flutter_markdown_plus.dart'
    show MarkdownElementBuilder;
import 'package:markdown/markdown.dart' as md;
import 'package:material_ui/material_ui.dart' hide Theme;
import 'package:myaniapp/common/markdown/markdown.dart' show MarkdownWidget;

class CenterNode extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    return Center(
      child: MarkdownWidget(
        data: element.textContent,
        body: true,
        padding: .zero,
      ),
    );
  }
}
