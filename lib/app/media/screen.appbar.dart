import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/image_viewer.dart';
import 'package:myaniapp/common/ink_well_image.dart';
import 'package:myaniapp/common/invisible_expanded_title.dart';
import 'package:myaniapp/common/list_setting_button.dart';
import 'package:myaniapp/common/media_cards/grid_card.dart';
import 'package:myaniapp/common/show.dart';
import 'package:myaniapp/common/widget_gradient.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/fragments/media.graphql.dart';
import 'package:myaniapp/graphql/__gen/media.graphql.dart';
import 'package:myaniapp/providers/list_settings.dart';

class MediaAppBar extends StatelessWidget {
  const MediaAppBar({
    super.key,
    required this.media,
    this.placeholder,
    required this.tab,
    required this.tabs,
  });

  final Query$Media$Media? media;
  final Fragment$MediaFragment? placeholder;
  final TabController tab;
  final List<(Widget, String)> tabs;

  @override
  Widget build(BuildContext context) {
    if (media == null && placeholder == null) return SliverAppBar();

    var dOrP = media ?? placeholder;

    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BackButton(
          color: Theme.of(context).colorScheme.onSurface,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color?>(
              Theme.of(context).colorScheme.surface.withValues(alpha: .3),
            ),
          ),
        ),
      ),
      actions: [
        MediaListSetting(tab: tab, tabs: tabs),
        const SizedBox(width: 5),
      ],
      title: InvisibleExpandedTitle(
        child: Text(dOrP!.title!.userPreferred!, maxLines: 2),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: BlurImage(
                enabled: media?.isAdult ?? false,
                child: WidgetGradient(
                  child: media?.bannerImage == null
                      ? Container(height: double.maxFinite, color: Colors.grey)
                      : InkWellImage(
                          onTap: () => ImageViewer.showImage(
                            context,
                            media!.bannerImage!,
                            tag: media!.bannerImage,
                          ),
                          child: Hero(
                            tag: media!.bannerImage!,
                            child: CachedImage(
                              media!.bannerImage!,
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                              height: double.maxFinite,
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Align(
              alignment: .bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  spacing: 8,
                  crossAxisAlignment: .end,
                  children: [
                    InkWellImage(
                      onTap: () => ImageViewer.showImage(
                        context,
                        dOrP.coverImage!.extraLarge!,
                        tag: dOrP.id,
                      ),
                      borderRadius: imageRadius,
                      child: Hero(
                        tag: dOrP.id,
                        child: ClipRRect(
                          borderRadius: imageRadius,
                          child: BlurImage(
                            enabled: dOrP.isAdult ?? false,
                            child: CachedImage(
                              dOrP.coverImage!.extraLarge!,
                              width: 95,
                              height: 140,
                              fit: .cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisSize: .min,
                        children: [
                          if (dOrP.isAdult == true)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red[700],
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Text(
                                "18+",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          GestureDetector(
                            onTap: media != null
                                ? () => showDialog(
                                    context: context,
                                    builder: (context) => _MediaTitleDialog(
                                      titles: media!.title!,
                                    ),
                                  )
                                : null,
                            child: Text(
                              dOrP.title!.userPreferred!,
                              maxLines: 3,
                              overflow: .ellipsis,
                              style: context.theme.textTheme.titleMedium
                                  ?.copyWith(color: Colors.blue[400]),
                            ),
                          ),
                          if (dOrP.format != null)
                            Text(dOrP.format!.name.capitalize()),
                          Show(
                            when: media != null,
                            child: () => Wrap(
                              spacing: 5,
                              children: [
                                TextButton.icon(
                                  label: Text(
                                    (media!.favourites ?? 0).abbreviate(),
                                    style: context.theme.textTheme.bodyMedium,
                                  ),
                                  icon: Icon(Icons.favorite, color: Colors.red),
                                  onPressed: null,
                                  style: ButtonStyle(
                                    padding: WidgetStatePropertyAll(
                                      EdgeInsets.zero,
                                    ),
                                    visualDensity: VisualDensity(
                                      horizontal: -4,
                                      vertical: -4,
                                    ),
                                  ),
                                ),
                                if (media!.averageScore != null)
                                  TextButton.icon(
                                    label: Text(
                                      (media!.averageScore ?? 0).abbreviate(),
                                      style: context.theme.textTheme.bodyMedium,
                                    ),
                                    icon: Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    onPressed: null,
                                    style: ButtonStyle(
                                      padding: WidgetStatePropertyAll(
                                        EdgeInsets.zero,
                                      ),
                                      visualDensity: VisualDensity(
                                        horizontal: -4,
                                        vertical: -4,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MediaTitleDialog extends StatelessWidget {
  const _MediaTitleDialog({super.key, required this.titles});

  final Query$Media$Media$title titles;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (titles.native != null)
              _MediaTitle(lang: "Native", title: titles.native!),
            if (titles.romaji != null)
              _MediaTitle(lang: "Romaji", title: titles.romaji!),
            if (titles.english != null)
              _MediaTitle(lang: "English", title: titles.english!),
          ],
        ),
      ),
    );
  }
}

class MediaListSetting extends ConsumerStatefulWidget {
  final TabController tab;
  final List<(Widget, String)> tabs;

  const MediaListSetting({super.key, required this.tab, required this.tabs});

  @override
  ConsumerState<MediaListSetting> createState() => _MediaListSettingState();
}

class _MediaListSettingState extends ConsumerState<MediaListSetting> {
  bool? show;

  @override
  void initState() {
    widget.tab.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.tab.removeListener(listener);
    super.dispose();
  }

  void listener() {
    if (widget.tabs[widget.tab.index].$2 == 'Relations') {
      setState(() => show = true);
    } else if (widget.tabs[widget.tab.index].$2 == 'Similar') {
      setState(() => show = false);
    } else if (show != null) {
      setState(() => show = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    var listSettings = ref.watch(listSettingsProvider);
    if (show == true) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: .4),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: ListSettingButton(
          type: listSettings.mediaRelations,
          onUpdate: (type) => ref
              .read(listSettingsProvider.notifier)
              .update(listSettings.copyWith(mediaRelations: type)),
        ),
      );
    } else if (show == false) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.4),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: ListSettingButton(
          type: listSettings.mediaSimilar,
          onUpdate: (type) => ref
              .read(listSettingsProvider.notifier)
              .update(listSettings.copyWith(mediaSimilar: type)),
        ),
      );
    }
    return const SizedBox();
  }
}

class _MediaTitle extends StatelessWidget {
  const _MediaTitle({required this.lang, required this.title});

  final String lang;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$lang: ", style: const TextStyle(fontWeight: FontWeight.bold)),
        Flexible(child: SelectableText(title)),
      ],
    );
  }
}
