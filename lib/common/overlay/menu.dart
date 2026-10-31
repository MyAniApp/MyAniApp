import 'package:material_ui/material_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myaniapp/common/ink_well_image.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/media_editor/media_editor.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/fragments/media.graphql.dart';

class OverlayMenu extends StatefulWidget {
  const OverlayMenu({super.key, required this.builder, required this.items});

  final Widget Function(BuildContext context, void Function() showOverlay)
  builder;
  final List<OverlayMenuItem> items;

  @override
  State<OverlayMenu> createState() => _OverlayMenuState();
}

class _OverlayMenuState extends State<OverlayMenu> {
  OverlayEntry? overlayEntry;
  ValueNotifier<double> listenable = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, showOverlay);
  }

  void showOverlay() {
    removeOverlay();

    var box = context.findRenderObject() as RenderBox;
    var pos = box.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => ValueListenableBuilder<double>(
        valueListenable: listenable,
        builder: (context, value, child) => LayoutBuilder(
          builder: (context, constraints) {
            double? left;
            double? top;
            if ((pos.dx - box.size.width - 20) < 0 &&
                (pos.dx + box.size.width + 10 + 200) > constraints.maxWidth) {
              left = pos.dx;
              top = pos.dy - 40 * widget.items.length;
            } else if ((pos.dx + box.size.width + 200) > constraints.maxWidth) {
              left = pos.dx - 50;
              top = pos.dy - 40 * widget.items.length;
            }

            if (top != null && top < 0) {
              top = pos.dy + box.size.height;
            }

            left ??= pos.dx + box.size.width + 5;
            top ??= pos.dy;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: startRemove,
              child:
                  Material(
                        color: Colors.black.withAlpha((255 * .2).truncate()),
                        child: Stack(
                          children: [
                            Positioned(
                              top: top,
                              left: left,
                              child: Container(
                                height: 40.0 * widget.items.length,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: context
                                      .theme
                                      .colorScheme
                                      .surfaceContainer,
                                  borderRadius: imageRadius,
                                  boxShadow: kElevationToShadow[2],
                                ),
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(0),
                                  children: [
                                    for (var item in widget.items)
                                      SizedBox(
                                        height: 40,
                                        child: InkWellImage(
                                          onTap: () => item.onTap(startRemove),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Row(
                                                children: [
                                                  if (item.icon != null) ...[
                                                    item.icon!,
                                                    const SizedBox(width: 10),
                                                  ],
                                                  item.child,
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate(
                        target: value,
                        onComplete: (controller) {
                          if (controller.isCompleted && value == 0)
                            removeOverlay();
                        },
                      )
                      .fadeIn(duration: 250.ms, curve: Curves.easeOut)
                      .then(delay: 3000.ms),
            );
          },
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void startRemove() {
    listenable.value = 0;
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
    listenable.value = 1;
  }
}

class OverlayMenuItem {
  final void Function(void Function() closeOverlay) onTap;
  final Widget child;
  final Widget? icon;

  OverlayMenuItem({required this.onTap, required this.child, this.icon});

  static List<OverlayMenuItem> defaultMediaItem({
    required BuildContext context,
    required Fragment$MediaFragment media,
    int? userId,
    required VoidCallback refetch,
  }) {
    return [
      OverlayMenuItem(
        onTap: (closeOverlay) {
          closeOverlay();
          MediaSheet.show(context, media!);
        },
        child: const Text("Preview"),
        icon: const Icon(Icons.remove_red_eye),
      ),
      if (userId != null)
        OverlayMenuItem(
          onTap: (closeOverlay) {
            closeOverlay();
            MediaEditorDialog.show(
              context,
              media,
              userId,
              onSave: refetch,
              onDelete: refetch,
            );
          },
          child: const Text("Editor"),
          icon: const Icon(Icons.edit),
        ),
    ];
  }
}
