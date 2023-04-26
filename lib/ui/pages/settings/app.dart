import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp_v2/providers/settings.dart';

@RoutePage()
class AppSettingsPage extends ConsumerWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
      ),
      body: ListView(
        children: [
          RadioListTile(
            value: ThemeMode.system,
            groupValue: settings.theme,
            onChanged: (value) => ref
                .read(settingsProvider.notifier)
                .changeTheme(value ?? ThemeMode.system),
            title: const Text('System'),
          ),
          RadioListTile(
            value: ThemeMode.light,
            groupValue: settings.theme,
            onChanged: (value) => ref
                .read(settingsProvider.notifier)
                .changeTheme(value ?? ThemeMode.system),
            title: const Text('Light'),
          ),
          RadioListTile(
            value: ThemeMode.dark,
            groupValue: settings.theme,
            onChanged: (value) => ref
                .read(settingsProvider.notifier)
                .changeTheme(value ?? ThemeMode.system),
            title: const Text('Dark'),
          ),
          ListTile(
            title: const Text('Colors'),
            onTap: () => context.router.pushNamed('colors'),
          ),
        ],
      ),
    );
  }
}
