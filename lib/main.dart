import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:myaniapp/background.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/notifications/push.dart';
import 'package:myaniapp/providers/shared_preferrences.dart';
import 'package:myaniapp/ui/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter();

  final prefs = await SharedPreferences.getInstance();

  if (!kIsWeb && Platform.isAndroid) {
    var service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: backgroundFunction,
        isForegroundMode: true,
        initialNotificationContent: 'Started on ${DateTime.now()}',
      ),
      iosConfiguration: IosConfiguration(),
    );

    service.startService();

    PushNotifications().requestPermission();
  }

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
