import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/ink_well_image.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/providers/settings.dart';

class GridCard extends StatelessWidget {
  static const double listRatio = 2 / 3;
  static const double gridRatio = 3 / 2;

  const GridCard({
    super.key,
    required this.image,
    this.aspectRatio = GridCard.gridRatio,
    this.underTitle,
    this.onTap,
    this.onLongPress,
    this.title,
    this.chips,
    this.blur = false,
    this.onDoubleTap,
  });

  // final GMediaFragment media;
  final double aspectRatio;
  final String image;
  final Widget? underTitle;
  final String? title;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final GestureDoubleTapCallback? onDoubleTap;
  final List<Widget>? chips;
  final bool blur;

  @override
  Widget build(BuildContext context) {
    // return InkWellImage(
    //   onTap: () => QR.to('/media/1'),
    //   child: AspectRatio(
    //     aspectRatio: aspectRatio,
    //     child: Column(
    //       children: [
    //         Expanded(
    //           child: CachedImage(image, fit: .cover, width: double.maxFinite),
    //         ),
    //         if (title != null) Text(title!, maxLines: 1),
    //       ],
    //     ),
    //   ),
    // );

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Stack(
        children: [
          InkWellImage(
            borderRadius: imageRadius,
            onLongPress: onLongPress,
            onTap: onTap,
            onDoubleTap: onDoubleTap,
            child: Container(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.surfaceContainerHighest
                    .withAlpha((255 * .7).truncate()),
                borderRadius: imageRadius,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: imageRadius,
                      child: BlurImage(
                        enabled: blur,
                        child: CachedImage(
                          image,
                          fit: BoxFit.fill,
                          width: double.maxFinite,
                        ),
                      ),
                    ),
                  ),
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Text(
                            title!,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          if (underTitle != null) underTitle!,
                        ],
                      ),
                    ),
                ],
              ),
              // child: CachedImage(
              //   image,
              //   imageBuilder: (context, imageProvider) => Column(
              //     children: [
              //       Expanded(
              //         child: ClipRRect(
              //           borderRadius: imageRadius,
              //           child: BlurImage(
              //             enabled: blur,
              //             child: Image(
              //               image: imageProvider,
              //               fit: BoxFit.fill,
              //               width: double.maxFinite,
              //             ),
              //           ),
              //         ),
              //       ),
              //       if (title != null)
              //         Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 5),
              //           child: Column(
              //             children: [
              //               Text(
              //                 title!,
              //                 overflow: TextOverflow.ellipsis,
              //                 style: Theme.of(context).textTheme.labelMedium,
              //               ),
              //               if (underTitle != null) underTitle!,
              //             ],
              //           ),
              //         ),
              //     ],
              //   ),
              // ),
            ),
          ),
          ...?chips,
        ],
      ),
    );
  }
}

class GridChip extends StatelessWidget {
  const GridChip({
    super.key,
    this.bottom,
    this.top,
    this.left,
    this.right,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.color,
  }) : noPositioned = false;

  const GridChip.nonPositioned({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.color,
  }) : noPositioned = true,
       bottom = null,
       top = null,
       right = null,
       left = null;

  final double? bottom;
  final double? top;
  final double? left;
  final double? right;
  final Color? color;
  final EdgeInsets padding;
  final Widget child;
  final bool noPositioned;

  @override
  Widget build(BuildContext context) {
    final w = Container(
      decoration: BoxDecoration(
        borderRadius: imageRadius,
        color:
            color ??
            context.theme.colorScheme.surfaceContainerHighest.withAlpha(150),
      ),
      padding: padding,
      child: child,
    );

    if (noPositioned) return w;

    return Positioned(
      left: left,
      bottom: bottom,
      top: top,
      right: right,
      child: w,
    );
  }
}

class BlurImage extends ConsumerWidget {
  const BlurImage({super.key, required this.child, this.enabled = false});

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var blurCovers = ref.watch(
      settingsProvider.select((value) => value.blurCovers),
    );

    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      enabled: blurCovers && enabled,
      child: child,
    );
  }
}
