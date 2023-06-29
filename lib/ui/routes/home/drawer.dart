import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/providers/settings.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:myaniapp/routes.gr.dart';
import 'package:myaniapp/ui/common/image.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);

    return Drawer(
      child: ListView(
        children: [
          if (user.value == null)
            ListTile(
              onTap: () => context.pushRoute(const LoginRoute()),
              title: const Text('Login'),
            )
          else ...[
            InkWell(
              onTap: () => context.pushRoute(
                UserRoute(
                  name: user.value!.name,
                ),
              ),
              child: UserAccountsDrawerHeader(
                accountName: Text(user.value!.name),
                currentAccountPicture:
                    CImage(imageUrl: user.value!.avatar!.large!),
                accountEmail: null,
                decoration: const BoxDecoration(),
                currentAccountPictureSize: const Size.square(90),
              ),
            ),
            ListTile(
              onTap: () => showDialog(
                context: context,
                builder: (context) => const LogoutDialog(),
              ),
              textColor: Theme.of(context).colorScheme.error,
              title: const Text('Logout'),
            ),
          ]
        ],
      ),
    );
  }
}

class LogoutDialog extends ConsumerWidget {
  const LogoutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: const Text("Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: () => context.popRoute(),
          child: const Text(
            'Cancel',
          ),
        ),
        TextButton(
          onPressed: () => {
            ref
                .read(settingsProvider.notifier)
                .logout()
                .then((value) => context.popRoute())
          },
          child: Text(
            'Logout',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
