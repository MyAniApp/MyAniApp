import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/viewer.graphql.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:myaniapp/ui/common/custom_dropdown.dart';

@RoutePage()
class AnilistSettingsPage extends ConsumerWidget {
  const AnilistSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: user.value!.options?.airingNotifications ?? false,
            onChanged: (value) =>
                ref.read(userProvider.notifier).updateSettings(
                      Variables$Mutation$UpdateUser(airingNotifications: value),
                    ),
            title: const Text('Airing Notifications'),
          ),
          SwitchListTile.adaptive(
            value: user.value?.options?.displayAdultContent ?? false,
            onChanged: (value) =>
                ref.read(userProvider.notifier).updateSettings(
                      Variables$Mutation$UpdateUser(
                        displayAdultContent: value,
                      ),
                    ),
            title: const Text('18+ content'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Title Language',
              style: theme.textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: CustomDropdown(
              hint: 'Title Language',
              value: user.value!.options?.titleLanguage,
              onChanged: (value) =>
                  ref.read(userProvider.notifier).updateSettings(
                        Variables$Mutation$UpdateUser(titleLanguage: value),
                      ),
              dropdownItems: [
                Enum$UserTitleLanguage.NATIVE,
                Enum$UserTitleLanguage.ROMAJI,
                Enum$UserTitleLanguage.ENGLISH,
              ]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: switch (e) {
                        Enum$UserTitleLanguage.ENGLISH =>
                          const Text('English (Attack on Titan)'),
                        Enum$UserTitleLanguage.ROMAJI =>
                          const Text('Romaji (Shingeki no Kyojin)'),
                        Enum$UserTitleLanguage.NATIVE =>
                          const Text('Native (進撃の巨人)'),
                        _ => Text(e.name)
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
