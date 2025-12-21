import 'dart:io';

var queryRegex = RegExp(r"(?:query|mutation) (\w+)[^]+?{[^]+?\n}");
var fragmentRegex = RegExp(r"fragment (\w+)[^]+?{[^]+?\n}");
var inlineFragment = RegExp(r"\.\.\.(\w+)");

String trimQuery(String str) {
  return (str
      .split('\n')
      .map((e) => e.trim())
      .where((e) => !e.startsWith('#'))
      .join(' '));
}

void main(List<String> args) {
  var dir = Directory(Platform.isWindows ? r".\lib\graphql" : "./lib/graphql");
  var fragmentDir = Directory(
    Platform.isWindows ? r".\lib\graphql\fragments" : "./lib/graphql/fragments",
  );

  List<File> graphqlQueriesFiles = dir
      .listSync()
      .whereType<File>()
      .where((element) => element.path.endsWith(".graphql"))
      .where((element) => !element.path.endsWith("schema.graphql"))
      .toList();
  // List
  List<File> fragmentFiles = fragmentDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((element) => element.path.endsWith(".graphql"))
      .toList();

  var queryFile = "";

  Map<String, String> fragments = {};

  for (var file in fragmentFiles) {
    var str = File(file.path).readAsStringSync();

    for (var match in fragmentRegex.allMatches(str)) {
      fragments[match.group(1)!] = trimQuery(match.group(0)!);
    }
  }

  // run twice to ensure inlines are handled
  handleInlines(fragments);
  handleInlines(fragments);

  // print(fragments['MediaListEntry']);

  for (var file in graphqlQueriesFiles) {
    var str = File(file.path).readAsStringSync();

    Map<String, String> fileFragments = {...fragments};

    for (var match in fragmentRegex.allMatches(str)) {
      fileFragments[match.group(1)!] = trimQuery(match.group(0)!);
    }

    handleInlines(fileFragments);
    handleInlines(fileFragments);

    for (var match in queryRegex.allMatches(str)) {
      var query = trimQuery(match.group(0)!);

      for (var inlineFragmentMatch in inlineFragment.allMatches(query)) {
        var name = inlineFragmentMatch.group(1)!;
        if (query.contains('fragment $name')) continue;

        if (fragments.containsKey(name))
          query += fragments[name]!;
        else if (fileFragments.containsKey(name))
          query += fileFragments[name]!;
      }

      query = Set.from(
        query.split("fragment").map((e) => e.trim()),
      ).join('fragment ');

      queryFile +=
          "\nvar ${toLowerCamelCase(match.group(1)!)}Query = r\"$query\";";
    }
  }

  File("./lib/graphql/queries.dart").writeAsString(queryFile.trim());
}

void handleInlines(Map<String, String> fragmentList) {
  for (var fragmentEntry in fragmentList.entries) {
    var value = fragmentEntry.value;
    for (var inlineMatch in inlineFragment.allMatches(fragmentEntry.value)) {
      // print(fragmentEntry.key);
      if (value.contains('fragment ${inlineMatch.group(1)!}')) continue;
      value += fragmentList[inlineMatch.group(1)!]!;
    }
    // if (fragmentEntry.key == 'ListGroup') print([value]);
    fragmentList[fragmentEntry.key] = value;
  }
}

String toLowerCamelCase(String s) {
  if (s.length < 2) return s.toLowerCase();
  return s[0].toLowerCase() + s.substring(1);
}

String removeFragmentDups(String str) {
  return Set.from(str.split("\n").map((e) => e.trim())).join("\n");
}
