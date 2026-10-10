import 'package:material_ui/material_ui.dart';
import 'package:html/dom.dart' as h;
import 'package:html/parser.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:myaniapp/common/markdown/markdown.dart';

var _doc = m.Document(
  blockSyntaxes: markdownConfig.blockSyntax,
  encodeHtml: false,
  extensionSet: markdownConfig.extensionSet,
  inlineSyntaxes: markdownConfig.inlineSynyax,
);

List<m.Node> markdownText(String text) {
  return _doc.parse(text);
}

///see this issue: https://github.com/dart-lang/markdown/issues/284#event-3216258013
///use [htmlToMarkdown] to convert HTML in [m.Text] to [m.Node]
void htmlToMarkdown(
  h.Node? node,
  int deep,
  List<m.Node> mNodes,
  m.InlineParser parser,
) {
  if (node == null) return;
  if (node is h.Text) {
    // add a space
    // for text as "<p>hello <i>world</i>!"
    // would be rendered as one word
    // but it still adds space to the <p> text
    mNodes.addAll(parser.document.parseInline(node.text.trim()));
  } else if (node is h.Element) {
    final tag = node.localName;
    List<m.Node> children = [];
    for (var e in node.nodes) {
      htmlToMarkdown(e, deep + 1, children, parser);
    }
    m.Element element;
    if (children.isEmpty && node.text.isNotEmpty) {
      children.addAll(parser.document.parseInline(node.text.trim()));
    }
    if (tag == 'img' || tag == 'video') {
      element = HtmlElement(tag!, children, node.text);
      element.attributes.addAll(node.attributes.cast());
    } else {
      // print(tag);
      element = HtmlElement(tag!, children, node.text);
      element.attributes.addAll(node.attributes.cast());
    }
    mNodes.add(element);
  }
}

final RegExp htmlRep = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);

///parse [m.Node] to [h.Node]
List<h.Node> parseHtml(m.Text node, {TextStyle? parentStyle}) {
  try {
    final text = node.textContent;
    if (!text.contains(htmlRep)) return [h.Text(node.text)];
    h.DocumentFragment document = parseFragment(text);
    return document.nodes.toList();
  } catch (e) {
    print(e);
    return [h.Text(node.text)];
  }
}

class HtmlElement extends m.Element {
  @override
  final String textContent;

  HtmlElement(super.tag, super.children, this.textContent);
}
