import 'package:markdown/markdown.dart';

class UserMentionSyntax extends InlineSyntax {
  UserMentionSyntax() : super(r"@([\w\d]+)");

  @override
  bool onMatch(InlineParser parser, Match match) {
    Element n = Element.text("a", match[0]!);
    n.attributes['href'] = "https://anilist.co/user/${match[1]}";
    parser.addNode(n);
    return true;
  }
}
