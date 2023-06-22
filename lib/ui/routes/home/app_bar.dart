import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key, this.bottom, this.actions});

  final TabBar? bottom;
  final List<Widget>? actions;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.onSecondary,
      leading: IconButton(
        icon: const Icon(Icons.account_circle),
        onPressed: () =>
            Scaffold.maybeOf(Scaffold.of(context).context)?.openDrawer(),
      ),
      bottom: bottom,
      actions: actions,
    );
  }
}
