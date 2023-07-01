import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/ui/common/image.dart';

class GridCards extends StatelessWidget {
  const GridCards({
    super.key,
    required this.card,
    required this.itemCount,
    this.primary,
    this.padding = EdgeInsets.zero,
  });

  final Widget Function(int index) card;
  final int itemCount;
  final bool? primary;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      primary: primary,
      padding: padding,
      gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) => card(index),
    );
  }
}

class GridCard extends StatelessWidget {
  const GridCard(
      {super.key,
      required this.imageUrl,
      this.chips,
      this.index,
      this.onDoubleTap,
      this.onTap,
      this.underTitle,
      this.title,
      this.onLongPress,
      this.aspectRatio = 2 / 3});

  final Widget Function(int index, ListStyle style)? underTitle;
  final List<Widget> Function(int index)? chips;
  final void Function(int index)? onDoubleTap;
  final void Function(int index)? onTap;
  final void Function(int index)? onLongPress;
  final String imageUrl;
  final int? index;
  final String? title;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: GestureDetector(
        onLongPress: onLongPress != null && index != null
            ? () => onLongPress!(index!)
            : null,
        // onLongPress: () => showCardSheet(context, media),
        onDoubleTap: onDoubleTap != null && index != null
            ? () => onDoubleTap!(index!)
            : null,
        onTap: onTap != null && index != null ? () => onTap!(index!) : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      // height: ,
                      decoration: BoxDecoration(
                        borderRadius: imageRadius,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (chips != null && index != null) ...chips!(index!),
                ],
              ),
            ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: underTitle != null && index != null
                            ? FontWeight.bold
                            : null,
                      ),
                ),
              ),
            if (underTitle != null && index != null)
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodySmall!,
                overflow: TextOverflow.ellipsis,
                child: underTitle!(index!, ListStyle.grid),
              )
          ],
        ),
      ),
    );
  }
}

class GridChip extends StatelessWidget {
  const GridChip({
    super.key,
    required this.child,
    this.top,
    this.bottom,
    this.right,
    this.left,
    this.maxWidth = 90,
  });

  final double? bottom;
  final Widget child;
  final double? left;
  final double? right;
  final double? top;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      top: top,
      right: right,
      left: left,
      child: Container(
        padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(fontWeight: FontWeight.normal),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          child: child,
        ),
      ),
    );
  }
}
