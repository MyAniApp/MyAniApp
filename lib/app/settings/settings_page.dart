import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/common/markdown/markdown.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/providers/settings.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SettingsSection(
            title: "Appearance",
            tiles: [
              SettingsTile.popup(
                title: "Theme",
                icon: const Icon(Icons.palette),
                subtitle: Text(settings.themeMode.name),
                items: const [
                  PopupMenuItem(
                    value: ThemeMode.light,
                    child: Text("Light"),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.dark,
                    child: Text("Dark"),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.system,
                    child: Text("System"),
                  ),
                ],
                onChanged: (value) =>
                    ref.read(settingsProvider.notifier).updateThemeMode(value),
              ),
              SettingsTile.popup(
                title: "Color",
                value: settings.primaryColor ?? Colors.blue[500],
                icon: const Icon(Icons.palette),
                subtitle: Container(
                  height: 20,
                  width: 20,
                  color: settings.primaryColor ?? Colors.blue[500],
                ),
                items: Colors.primaries
                    .map(
                      (e) => PopupMenuItem(
                        value: e.shade500,
                        child: Container(
                          width: double.maxFinite,
                          height: 40,
                          color: e.shade500,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => ref
                    .read(settingsProvider.notifier)
                    .updatePrimaryColor(value),
              ),
              SettingsTile.switchTile(
                title: "Blur 18+ covers",
                value: settings.blurCovers,
                onChanged: (value) =>
                    ref.read(settingsProvider.notifier).updateBlurCovers(value),
              )
            ],
          ),
          SettingsSection(
            title: "Chat",
            tiles: [
              SettingsTile.switchTile(
                value: settings.showEmbedMediaCard,
                onChanged: (p0) => ref
                    .read(settingsProvider.notifier)
                    .updateEmbedMediaCard(p0),
                title:
                    "Show embed media card (more likely to hit the rate limit)",
                subtitle: const SizedBox(
                  height: 120,
                  child: MarkdownWidget(
                    data: "https://anilist.co/anime/21/ONE-PIECE/",
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key, required this.tiles, required this.title});

  final List<SettingsTile> tiles;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            title,
            style: context.theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Material(
          color: context.theme.colorScheme.surfaceContainerHighest.withOpacity(.3),
          borderRadius: imageRadius,
          borderOnForeground: true,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: tiles.length,
            itemBuilder: (context, index) => tiles[index],
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                height: 1,
                thickness: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsTile<T> extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
  })  : switchValue = null,
        onSwitchChanged = null,
        popupItems = null,
        onPopupChanged = null,
        initialValue = null;

  const SettingsTile.switchTile({
    super.key,
    required this.title,
    this.subtitle,
    required bool value,
    required Function(bool) onChanged,
    this.icon,
  })  : switchValue = value,
        onSwitchChanged = onChanged,
        popupItems = null,
        onPopupChanged = null,
        initialValue = null;

  const SettingsTile.popup({
    super.key,
    required this.title,
    this.subtitle,
    required List<PopupMenuEntry<T>> items,
    required Function(T value) onChanged,
    T? value,
    this.icon,
  })  : popupItems = items,
        onPopupChanged = onChanged,
        switchValue = null,
        onSwitchChanged = null,
        initialValue = value;

  final String title;
  final Widget? subtitle;
  final Icon? icon;
  final bool? switchValue;
  final Function(bool value)? onSwitchChanged;
  final List<PopupMenuEntry<T>>? popupItems;
  final T? initialValue;
  final Function(T value)? onPopupChanged;

  @override
  Widget build(BuildContext context) {
    var tile = Padding(
      padding: const EdgeInsetsDirectional.only(
          start: 24, end: 20, top: 10, bottom: 10),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconTheme(
                data: IconThemeData(color: context.theme.hintColor),
                child: icon!,
              ),
            ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.theme.textTheme.bodyLarge,
                ),
                if (subtitle != null)
                  DefaultTextStyle(
                    style: (context.theme.primaryTextTheme.bodyMedium ??
                            const TextStyle())
                        .copyWith(color: context.theme.hintColor),
                    child: subtitle!,
                  )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          if (switchValue != null)
            Switch.adaptive(
              value: switchValue!,
              onChanged: onSwitchChanged,
            ),
        ],
      ),
    );

    if (switchValue != null) {
      return InkWell(
        onTap: () => onSwitchChanged!(!switchValue!),
        child: tile,
      );
    } else if (popupItems != null) {
      return PopupMenuButton(
        initialValue: initialValue,
        position: PopupMenuPosition.under,
        tooltip: "",
        itemBuilder: (context) => popupItems!,
        onSelected: onPopupChanged,
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 100),
        child: tile,
      );
    }

    return tile;
  }
}
