import 'package:flutter/material.dart';
import 'package:gql/ast.dart';
import 'package:html/dom.dart' as h;
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';
import 'package:markdown/markdown.dart' as m;
import 'package:markdown_widget/markdown_widget.dart';
import 'package:myaniapp/common/markdown/markdown.dart';

var _doc = m.Document(
  blockSyntaxes: markdownGenerator.blockSyntaxList,
  encodeHtml: false,
  extensionSet: markdownGenerator.extensionSet,
  inlineSyntaxes: markdownGenerator.inlineSyntaxList,
);

List<m.Node> markdownText(String text) {
  return _doc.parse(text);
}

///see this issue: https://github.com/dart-lang/markdown/issues/284#event-3216258013
///use [htmlToMarkdown] to convert HTML in [m.Text] to [m.Node]
void htmlToMarkdown(
    h.Node? node, int deep, List<m.Node> mNodes, WidgetVisitor visitor) {
  if (node == null) return;
  if (node is h.Text) {
    mNodes.addAll(markdownText(node.text));
  } else if (node is h.Element) {
    final tag = node.localName;
    List<m.Node> children = [];
    for (var e in node.nodes) {
      htmlToMarkdown(e, deep + 1, children, visitor);
    }
    m.Element element;
    if (children.isEmpty && node.text.isNotEmpty) {
      children.addAll(markdownText(node.text));
    }
    if (tag == MarkdownTag.img.name || tag == 'video') {
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
List<SpanNode> parseHtml(
  m.Text node, {
  ValueCallback<dynamic>? onError,
  WidgetVisitor? visitor,
  TextStyle? parentStyle,
}) {
  try {
    final text = node.textContent;
    if (!text.contains(htmlRep)) return [TextNode(text: node.text)];
    h.DocumentFragment document = parseFragment(text);
    return HtmlToSpanVisitor(visitor: visitor, parentStyle: parentStyle)
        .toVisit(document.nodes.toList());
  } catch (e) {
    onError?.call(e);
    print(e);
    return [TextNode(text: node.text)];
  }
}

class HtmlElement extends m.Element {
  @override
  final String textContent;

  HtmlElement(super.tag, super.children, this.textContent);
}

class HtmlToSpanVisitor extends TreeVisitor {
  final List<SpanNode> _spans = [];
  final List<SpanNode> _spansStack = [];
  final WidgetVisitor visitor;
  final TextStyle parentStyle;

  HtmlToSpanVisitor({WidgetVisitor? visitor, TextStyle? parentStyle})
      : visitor = visitor ?? WidgetVisitor(),
        parentStyle = parentStyle ?? const TextStyle();

  List<SpanNode> toVisit(List<h.Node> nodes) {
    _spans.clear();
    for (final node in nodes) {
      final emptyNode = ConcreteElementNode(style: parentStyle);
      _spans.add(emptyNode);
      _spansStack.add(emptyNode);
      visit(node);
      _spansStack.removeLast();
    }
    final result = List.of(_spans);
    _spans.clear();
    _spansStack.clear();
    return result;
  }

  // html block of text
  // ex: <hr> jdshfaklashf (html text block!) <hr>
  @override
  void visitText(h.Text node) {
    final last = _spansStack.last;
    if (last is ElementNode) {
      // print(node.text);
      var mdNode = markdownText(node.text);
      var spans = visitor.visit(mdNode);
      for (var s in spans) last.accept(s);
    }
  }

  // html tag
  @override
  void visitElement(h.Element node) {
    final localName = node.localName ?? '';
    final mdElement = m.Element(localName, []);
    mdElement.attributes.addAll(node.attributes.cast());
    SpanNode spanNode = visitor.getNodeByElement(mdElement, visitor.config);
    // parse the html inside including markdown
    if (spanNode is ElementNode) {
      List<m.Node> nodes = [];
      htmlToMarkdown(node, 0, nodes, visitor);
      var spans = visitor.visit(nodes);
      for (var span in spans) spanNode.accept(span);
    } else {
      final n = ConcreteElementNode(tag: localName, style: parentStyle);
      n.accept(spanNode);
      spanNode = n;
    }
    final last = _spansStack.last;
    if (last is ElementNode) {
      last.accept(spanNode);
    }
    _spansStack.add(spanNode);
    _spansStack.removeLast();
  }
}
