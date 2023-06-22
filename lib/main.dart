import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/providers/shared_preferrences.dart';
import 'package:myaniapp/ui/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefProvider.overrideWithValue(prefs),
      ],
      child: GraphQLProvider(
        client: client,
        child: const App(),
      ),
    ),
  );
}

var logger = Logger();
