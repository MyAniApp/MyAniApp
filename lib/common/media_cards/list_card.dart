import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/overlay/menu.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.image,
    this.underTitle,
    this.title,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.blur = false,
    this.overlayItems,
  });

  final String image;
  final Widget? underTitle;
  final String? title;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final GestureDoubleTapCallback? onDoubleTap;
  final bool blur;
  final List<OverlayMenuItem>? overlayItems;

  @override
  Widget build(BuildContext context) {
    card(VoidCallback? onLongPress) => Card(
      child: InkWell(
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onTap: onTap,
        borderRadius: imageRadius,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: 85,
              child: ClipRRect(
                borderRadius: imageRadius,
                child: CachedImage(image, fit: BoxFit.fill),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        title!,
                        maxLines: 3,
                        style: context.theme.textTheme.titleSmall,
                      ),
                    ),
                  if (underTitle != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: underTitle!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (overlayItems != null) {
      return OverlayMenu(
        builder: (context, showOverlay) => card(showOverlay),
        items: overlayItems!,
      );
    }

    return card(onLongPress);
  }
}

class CompactListCard extends StatelessWidget {
  final Widget? underTitle;
  final String? title;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final GestureDoubleTapCallback? onDoubleTap;
  final List<OverlayMenuItem>? overlayItems;

  const CompactListCard({
    super.key,
    this.underTitle,
    this.title,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.overlayItems,
  });

  @override
  Widget build(BuildContext context) {
    card(VoidCallback? onLongPress) => InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: ListTile(title: Text(title!), subtitle: underTitle),
    );

    if (overlayItems != null) {
      return OverlayMenu(
        builder: (context, showOverlay) => card(showOverlay),
        items: overlayItems!,
      );
    }

    return card(onLongPress);
  }
}
