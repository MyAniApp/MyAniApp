import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/providers/shared_preferrences.dart';
import 'package:myaniapp/ui/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  assert(isDevmode = true);
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}
