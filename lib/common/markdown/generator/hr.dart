import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart' as md;

md.SpanNodeGeneratorWithTag hrGenerator = md.SpanNodeGeneratorWithTag(
  tag: "hr",
  generator: (e, config, visitor) => DividerNode(),
);

class DividerNode extends md.ElementNode {
  @override
  InlineSpan build() {
    return const WidgetSpan(
      child: Divider(),
    );
  }
}
