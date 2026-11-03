import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp/common/comment.dart';
import 'package:myaniapp/common/markdown/markdown.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/providers/user.dart';

class MarkdownEditor extends HookConsumerWidget {
  const MarkdownEditor({
    super.key,
    this.text,
    required this.onSave,
    this.hint,
    this.leading,
  });

  final String? text;
  final String? hint;
  final Function(String text) onSave;
  final Widget? leading;

  static void show(
    BuildContext context, {
    String? text,
    required Function(String text) onSave,
    String? hint,
    Widget? leading,
  }) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) => Dialog.fullscreen(
        child: MarkdownEditor(
          onSave: onSave,
          text: text,
          hint: hint,
          leading: leading,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pageController = usePageController();
    var bodyController = useTextEditingController();
    var focusNode = useFocusNode();

    return Scaffold(
      appBar: AppBar(
        leading: _BackButton(pageController),
        actions: [
          _PageButton(
            pageController,
            onSave: () {
              onSave(bodyController.text);
              context.pop();
            },
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ?leading,
              Container(
                color: context.theme.colorScheme.surfaceContainerHigh,
                child: MarkdownToolbar(
                  controller: bodyController,
                  focusNode: focusNode,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.sizeOf(context).shortestSide,
                ),
                child: TextArea(
                  focusNode: focusNode,
                  editingController: bodyController,
                  hint: hint,
                ),
              ),
            ],
          ),
          _Preview(bodyController: bodyController),
        ],
      ),
    );
  }
}

class _Preview extends HookConsumerWidget {
  const _Preview({required this.bodyController});

  final TextEditingController bodyController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var text = useValueListenable(bodyController);
    var user = ref.read(
      userProvider.select((u) => u.value?.parsedData?.Viewer),
    );

    return ListView(
      children: [
        Comment(
          avatar:
              user?.avatar?.large ??
              'https://s4.anilist.co/file/anilistcdn/user/avatar/large/default.png',
          body: MarkdownWidget.body(
            data: text.text,
            shrinkWrap: true,
            selectable: true,
          ),
          collapsible: false,
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          username: user?.name ?? 'Test',
        ),
      ],
    );
  }
}

class _BackButton extends HookWidget {
  const _BackButton(this.pageController);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final page = useListenableSelector(
      pageController,
      () => pageController.page,
    );

    if (page == 0 || page == null) {
      return IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () => context.pop(),
      );
    }

    return BackButton(
      onPressed: () => pageController.animateToPage(
        0,
        duration: Durations.medium2,
        curve: Curves.easeOut,
      ),
    );
  }
}

class _PageButton extends HookWidget {
  const _PageButton(this.pageController, {this.onSave});

  final PageController pageController;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    final page = useListenableSelector(
      pageController,
      () => pageController.page,
    );

    if (page == 0 || page == null) {
      return TextButton(
        onPressed: () {
          pageController.animateToPage(
            2,
            duration: Durations.medium2,
            curve: Curves.easeIn,
          );
        },
        child: Text('Preview'),
      );
    }
    return IconButton(
      icon: Icon(Icons.send),
      onPressed: () {
        onSave?.call();
      },
    );
  }
}

class TextArea extends StatefulWidget {
  const TextArea({
    super.key,
    required this.focusNode,
    required this.editingController,
    this.hint,
  });

  final FocusNode focusNode;
  final TextEditingController editingController;
  final String? hint;

  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TextField(
      focusNode: widget.focusNode,
      controller: widget.editingController,
      maxLines: null,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(8),
        hintText: widget.hint ?? "Type here",
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PreviewButton extends StatefulWidget {
  const _PreviewButton({
    required this.editingController,
    required this.onPressed,
  });

  final TextEditingController editingController;
  final VoidCallback onPressed;

  @override
  State<_PreviewButton> createState() => _PreviewButtonState();
}

class _PreviewButtonState extends State<_PreviewButton> {
  @override
  void initState() {
    super.initState();
    widget.editingController.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.editingController.removeListener(listener);
  }

  void listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.editingController.text.length > 2
          ? widget.onPressed
          : null,
      child: const Text("Preview"),
    );
  }
}

class MarkdownToolbar extends StatelessWidget {
  const MarkdownToolbar({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        IconButton(
          onPressed: () {
            replaceAround(getSelectedTextRange(), "__", "__");
            focusNode.requestFocus();
          },
          icon: const Icon(Icons.format_bold),
        ),
        IconButton(
          onPressed: () {
            replaceAround(getSelectedTextRange(), "_", "_");
            focusNode.requestFocus();
          },
          icon: const Icon(Icons.format_italic),
        ),
        IconButton(
          onPressed: () {
            replaceAround(getSelectedTextRange(), "~~", "~~");
            focusNode.requestFocus();
          },
          icon: const Icon(Icons.format_strikethrough),
        ),
        IconButton(
          onPressed: () {
            replaceAround(getSelectedTextRange(), "~!", "!~");
            focusNode.requestFocus();
          },
          icon: Icon(Icons.visibility_off),
        ),
        IconButton(
          onPressed: () {
            replaceAround(getSelectedTextRange(), "\n> ", "");
            focusNode.requestFocus();
          },
          icon: const Icon(Icons.format_quote_sharp),
        ),
        IconButton(
          onPressed: () {
            replaceAround(getSelectedTextRange(), "\n# ", "");
            focusNode.requestFocus();
          },
          icon: Text(
            "H",
            style: context.theme.textTheme.titleMedium?.copyWith(
              color: context.theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(onPressed: () => _addLink(context), icon: Icon(Icons.link)),
        IconButton(
          onPressed: () => _addImage(context),
          icon: Icon(Icons.image),
        ),
        IconButton(
          onPressed: () {
            replaceAround(getSelectedTextRange(), "\n- ", "");
            focusNode.requestFocus();
          },
          icon: Icon(Icons.format_list_bulleted),
        ),
        IconButton(
          onPressed: () {
            replaceAround(getSelectedTextRange(), "\n1. ", "");
            focusNode.requestFocus();
          },
          icon: Icon(Icons.format_list_numbered),
        ),
        IconButton(
          onPressed: () {
            replaceAround(getSelectedTextRange(), "\n~~~", "~~~");
            focusNode.requestFocus();
          },
          icon: Icon(Icons.format_align_center),
        ),
        IconButton(
          onPressed: () {
            replaceAround(getSelectedTextRange(), "`", "`");
            focusNode.requestFocus();
          },
          icon: Icon(Icons.code),
        ),
      ],
    );
  }

  void _addImage(BuildContext context) async {
    final imageUrl = await showDialog<String>(
      context: context,
      builder: (context) => ImageDialog(),
    );

    if (imageUrl?.isNotEmpty == true) {
      replaceAround(getSelectedTextRange(), "img220($imageUrl)", "");
      focusNode.requestFocus();
    }
  }

  void _addLink(BuildContext context) async {
    final selectedText = controller.text.substring(
      getSelectedTextRange().$1,
      getSelectedTextRange().$2,
    );
    final linkData = await showDialog<List<String>?>(
      context: context,
      builder: (context) => LinkDialog(
        defaultTitle: selectedText.isNotEmpty ? selectedText : null,
      ),
    );
    if (linkData != null && linkData.first.isNotEmpty) {
      replaceRange(
        getSelectedTextRange(),
        "[${linkData.last.isNotEmpty ? linkData.last : 'link'}](${linkData.first})",
      );
      focusNode.requestFocus();
    }
  }

  (int start, int end) getSelectedTextRange() {
    // print(_editingController.selection.extentOffset);
    int start =
        controller.selection.baseOffset < controller.selection.extentOffset
        ? controller.selection.baseOffset
        : controller.selection.extentOffset;

    var end =
        controller.selection.baseOffset > controller.selection.extentOffset
        ? controller.selection.baseOffset
        : controller.selection.extentOffset;

    return (start == -1 ? 0 : start, end == -1 ? 0 : end);
  }

  void replaceAround(
    (int start, int end) range,
    String startStr,
    String endStr,
  ) {
    var text = controller.text.substring(range.$1, range.$2);
    controller.text = controller.text.replaceRange(
      range.$1,
      range.$2,
      '$startStr$text$endStr',
    );

    if (controller.text.isNotEmpty) {
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: range.$1 + startStr.length),
      );
    }
  }

  void replaceRange((int start, int end) range, String replacement) {
    controller.text = controller.text.replaceRange(
      range.$1,
      range.$2,
      replacement,
    );

    if (controller.text.isNotEmpty) {
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: range.$1 + replacement.length),
      );
    }
  }
}

class ImageDialog extends HookWidget {
  const ImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(
              "Add Image",
              style: context.theme.primaryTextTheme.titleMedium,
            ),
            SizedBox(height: 10),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "URL",
              ),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 5,
              mainAxisAlignment: .end,
              children: [
                OutlinedButton(
                  onPressed: () => context.pop(),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () => context.pop(textController.text),
                  child: Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LinkDialog extends HookWidget {
  const LinkDialog({super.key, this.defaultTitle});

  final String? defaultTitle;

  @override
  Widget build(BuildContext context) {
    final linkController = useTextEditingController();
    final linkTitleController = useTextEditingController(text: defaultTitle);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisSize: .min,
          children: [
            Text("Add Link", style: context.theme.primaryTextTheme.titleMedium),
            SizedBox(height: 15),
            TextField(
              controller: linkController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Link URL",
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: linkTitleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Link Text (Optional)",
              ),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 5,
              mainAxisAlignment: .end,
              children: [
                OutlinedButton(
                  onPressed: () => context.pop(),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () => context.pop([
                    linkController.text,
                    linkTitleController.text,
                  ]),
                  child: Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
