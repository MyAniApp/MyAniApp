import 'package:markdown/markdown.dart';

class CustomHeaderSyntax extends HeaderSyntax {
  @override
  RegExp get pattern => RegExp(r'^ {0,3}(#{1,6})(?:.*?)?(?:\s(#*)\s*)?$');
}
