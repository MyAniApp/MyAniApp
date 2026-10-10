import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:material_ui/material_ui.dart';
import "package:markdown/markdown.dart" as md2;
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/image_viewer.dart';
import 'package:myaniapp/common/ink_well_image.dart';

class AnilistImageSyntax extends md2.InlineSyntax {
  AnilistImageSyntax() : super(r"(?:i|I)mg(\d+)?(%)?\((.*?)\)");

  @override
  bool onMatch(md2.InlineParser parser, Match match) {
    var src = match.group(3);
    var height = match.group(1);

    if (src != null) {
      // print(src);
      var elm = md2.Element("img", []);
      elm.attributes["src"] = src;
      if (height != null) {
        if (match.group(2) == null) {
          elm.attributes["height"] = height;
        } else {
          elm.attributes["heightPercent"] = height;
        }
      }
      // print(elm.tag);
      parser.addNode(elm);
    }

    return true;
  }
}

class ImageBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md2.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    // print(element.textContent);
    if (element.tag != "img") return null;
    final src = element.attributes['src'];
    if (src == null) return null;
    final height = double.tryParse(
      element.attributes['height']?.replaceAll("px", "") ?? "",
    );
    final heightPercent = element.attributes['heightPercent'];
    // return Text('dsfh');
    final key = UniqueKey();
    return InkWellImage(
      onLongPress: () => ImageViewer.showImage(context, src, tag: key),
      child: Hero(
        tag: key,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height ?? 400),
          child: CachedImage(src),
        ),
      ),
    );
  }
}
