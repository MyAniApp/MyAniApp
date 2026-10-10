import 'package:markdown/markdown.dart';
import 'package:markdown/src/util.dart';
import 'package:myaniapp/common/markdown/generator/html.dart';
import 'package:html/dom.dart' as h;

// >
const int $lt = 0x3C;

class HTMLInlineSynyax extends InlineHtmlSyntax {
  /// Tries to match at the parser's current position.
  ///
  /// The parser's position can be overriden with [startMatchPos].
  /// Returns whether or not the pattern successfully matched.
  static final _codeBlock = RegExp(r'(`+(?!`))((?:.|\n)*?[^`])\1(?!`)');
  @override
  bool tryMatch(InlineParser parser, [int? startMatchPos]) {
    startMatchPos ??= parser.pos;

    // Before matching with the regular expression [pattern], which can be
    // expensive on some platforms, check if even the first character matches
    // this syntax.
    if ($lt != null && parser.source.codeUnitAt(startMatchPos) != $lt) {
      return false;
    }

    // parses all the tag in the line (the pattern only match tags not the whole block)
    final allMatches = pattern.allMatches(parser.source, startMatchPos);
    if (allMatches.isEmpty) return false;

    // Write any existing plain text up to this point.
    parser.writeText();

    if (onMatch(parser, allMatches.last))
      parser.consume(allMatches.last.end - allMatches.first.start);
    return true;
  }

  @override
  bool onMatch(InlineParser parser, Match match) {
    var htmlString = parser.source.substring(parser.pos, match.end);
    // dont parse html in code blocks (ex: `<hr>`)
    htmlString = htmlString.replaceAllMapped(
      _codeBlock,
      (match) => escapeHtml(match[0]!),
    );
    final parsedHtml = parseHtml(Text(htmlString));
    final mdNodes = <Node>[];

    for (h.Node node in parsedHtml) {
      htmlToMarkdown(node, 0, mdNodes, parser);
    }

    for (Node node in mdNodes) {
      parser.addNode(node);
    }

    // parse un

    // if (match != null) parser.advanceBy(match[0]!.length);

    return true;

    // return super.onMatch(parser, match);
  }
}
