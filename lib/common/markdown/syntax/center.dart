import 'package:markdown/markdown.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:myaniapp/common/markdown/generator/center.dart';

class CenterInlineSyntax extends InlineSyntax {
  CenterInlineSyntax() : super(r"((?:~~~)|(?:```))([\s\S]+)(?:\1)");

  @override
  bool onMatch(InlineParser parser, Match match) {
    Element elm = Element(
      centerGenerator.tag,
      parser.document.parseInline(match[2] ?? ''),
    );
    parser.addNode(elm);

    return true;
  }
}

class CenterBlockSyntax extends BlockSyntax {
  CenterBlockSyntax();

  @override
  Node? parse(BlockParser parser) {
    Element elm = Element('p', [
      UnparsedContent(parser.current.content
          .substring(3, parser.current.content.length - 3))
    ]);
    // parser.advance();
    return elm;
  }

  @override
  // TODO: implement pattern
  RegExp get pattern => RegExp(r"^~~~([\s\S]*?)~~~$");
}
