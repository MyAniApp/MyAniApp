import 'package:markdown_widget/widget/all.dart';

var bGenerator = SpanNodeGeneratorWithTag(
    tag: 'b', generator: (e, config, visitor) => StrongNode());
