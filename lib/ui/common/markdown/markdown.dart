import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart' as md2;
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/ui/common/image.dart';
import 'package:myaniapp/ui/common/markdown/custom_node.dart';
import 'package:myaniapp/ui/common/markdown/generators/br.dart';
import 'package:myaniapp/ui/common/markdown/generators/i.dart';
import 'package:myaniapp/ui/common/markdown/generators/img.dart';
import 'package:myaniapp/ui/common/markdown/generators/spolier.dart';

var removeRegex = RegExp(r'~{3}([\s\S]*?)~{3}|(<br>)(?:<br>)?', dotAll: true);

class Markdown extends StatelessWidget {
  const Markdown({
    super.key,
    required this.data,
    this.selectable = true,
  });

  final String data;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    // print(data);
    var markdown = data.replaceAllMapped(removeRegex, (match) {
      // logger.i(match.groups([1, 2]));
      return match.group(1) ?? '';
    });

    // logger.i(data);

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: md2.MarkdownWidget(
        data: markdown,
        shrinkWrap: true,
        selectable: selectable,
        markdownGeneratorConfig: md2.MarkdownGeneratorConfig(
          generators: [iWithTag, spoilerWithTag],
          inlineSyntaxList: [
            ISyntax(),
            ImgSyntax(),
            SpoilerSyntax(),
            BrSyntax(),
          ],
          textGenerator: (node, config, visitor) =>
              CustomTextNode(node.textContent, config, visitor),
        ),
        config: md2.MarkdownConfig(
          configs: [
            const md2.PConfig(
              textStyle: TextStyle(),
            ),
            const md2.LinkConfig(
              style: TextStyle(color: linkColor),
            ),
            md2.ImgConfig(
              builder: (url, attributes) {
                double? width;
                double? height;
                if (attributes['width'] != null) {
                  width = double.tryParse(attributes['width']!);
                }
                if (attributes['height'] != null) {
                  height = double.tryParse(attributes['height']!);
                }

                return SizedBox(
                  height: height,
                  width: width,
                  child: CImage(
                    imageUrl: url,
                    viewer: true,
                  ),
                );
              },
            ),
            const md2.CodeConfig(style: TextStyle()),
          ],
        ),
      ),
    );
  }
}
