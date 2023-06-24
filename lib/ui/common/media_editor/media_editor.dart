import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/common/media_editor/media_editor.graphql.dart';
import 'package:myaniapp/providers/media_editor.dart';
import 'package:myaniapp/ui/common/custom_dropdown.dart';
import 'package:myaniapp/ui/common/delete.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/numer_picker.dart';

class MediaEditorDialog extends ConsumerWidget {
  const MediaEditorDialog({
    super.key,
    required this.media,
    this.onDelete,
    this.onSave,
  });

  final Fragment$MediaFragment media;
  final void Function()? onDelete;
  final void Function()? onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mediaEditor = ref.watch(mediaEditorProvider(media));

    // print(mediaEditor.isLoading);

    return mediaEditor.when(
      data: (data) => MediaEditor(
        media: media,
        entry: data,
        onDelete: onDelete,
        onSave: onSave,
      ),
      error: (error, stackTrace) => Scaffold(
        appBar: AppBar(),
        body: GraphqlError(exception: error as OperationException),
      ),
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}

class MediaEditor extends ConsumerStatefulWidget {
  const MediaEditor({
    super.key,
    required this.entry,
    required this.media,
    this.onDelete,
    this.onSave,
  });

  final Fragment$MediaListEntry entry;
  final void Function()? onDelete;
  final void Function()? onSave;
  final Fragment$MediaFragment media;

  @override
  ConsumerState<MediaEditor> createState() => _MediaEditorState();
}

class _MediaEditorState extends ConsumerState<MediaEditor> {
  late Variables$Mutation$SaveMediaListEntry options;
  late Variables$Mutation$SaveMediaListEntry og;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    options = Variables$Mutation$SaveMediaListEntry(
      completedAt: widget.entry.completedAt != null
          ? Input$FuzzyDateInput(
              day: widget.entry.completedAt!.day,
              month: widget.entry.completedAt!.month,
              year: widget.entry.completedAt!.year)
          : null,
      startedAt: widget.entry.startedAt != null
          ? Input$FuzzyDateInput(
              day: widget.entry.startedAt!.day,
              month: widget.entry.startedAt!.month,
              year: widget.entry.startedAt!.year)
          : null,
      hiddenFromStatusLists: widget.entry.hiddenFromStatusLists,
      notes: widget.entry.notes,
      priority: widget.entry.priority,
      private: widget.entry.private,
      progress: widget.entry.progress,
      progressVolumes: widget.entry.progressVolumes,
      repeat: widget.entry.repeat,
      score: widget.entry.score,
      status: widget.entry.status,
    );

    og = Variables$Mutation$SaveMediaListEntry.fromJson(options.toJson());
    textController = TextEditingController.fromValue(
        TextEditingValue(text: options.notes ?? ''));

    textController.addListener(textListener);
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  void textListener() {
    if (options.notes != textController.text) {
      setState(() => options = options.copyWith(notes: textController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.entry.id != -1)
            IconButton(
              padding: const EdgeInsets.all(16),
              onPressed: () async {
                var shouldDelete = await showDeleteDialog(context);

                if (shouldDelete == true) {
                  context.popRoute();
                  client.value
                      .mutate$DeleteMediaListEntry(
                        Options$Mutation$DeleteMediaListEntry(
                          variables: Variables$Mutation$DeleteMediaListEntry(
                            id: widget.entry.id,
                          ),
                        ),
                      )
                      .then((value) => widget.onDelete?.call());
                }
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          IconButton(
            padding: const EdgeInsets.all(16),
            onPressed: () {
              // widget.entry.
              if (options != og) {
                ref
                    .read(mediaEditorProvider(widget.media).notifier)
                    .save(options)
                    .then((_) => widget.onSave?.call());
              }
              context.popRoute();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          MasonryGridView.custom(
            gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
            ),
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childrenDelegate: SliverChildListDelegate(
              [
                CustomDropdown(
                  hint: 'Status',
                  value: options.status,
                  onChanged: (value) =>
                      setState(() => options = options.copyWith(status: value)),
                  dropdownItems: Enum$MediaListStatus.values
                      .takeWhile(
                          (value) => value != Enum$MediaListStatus.$unknown)
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name.capitalize()),
                        ),
                      )
                      .toList(),
                ),
                NumberPicker(
                  number:
                      (options.progress ?? 0) == 0 ? null : options.progress,
                  hint:
                      '${widget.entry.media!.type == Enum$MediaType.ANIME ? 'Episode' : 'Chapter'} Progress',
                  onIncrement: () {
                    var number = (options.progress ?? 0) + 1;

                    if (widget.entry.media!.episodes != null &&
                        number >= widget.entry.media!.episodes!) {
                      if (options.status != Enum$MediaListStatus.COMPLETED) {
                        setState(
                          () => options = options.copyWith(
                            progress: number,
                            status: Enum$MediaListStatus.COMPLETED,
                          ),
                        );
                      }
                      return;
                    }

                    setState(
                      () => options = options.copyWith(
                          progress: (options.progress ?? 0) + 1),
                    );
                  },
                  onDecrement: () {
                    var number = (options.progress ?? 0) - 1;

                    if (number < 0) return;
                    if (widget.entry.media!.episodes != null &&
                        options.progress! >= widget.entry.media!.episodes! &&
                        options.status == Enum$MediaListStatus.COMPLETED) {
                      return setState(
                        () => options = options.copyWith(
                            progress: number, status: og.status),
                      );
                    }

                    setState(
                      () => options = options.copyWith(progress: number),
                    );
                  },
                ),
                NumberPicker(
                  number: (options.repeat ?? 0) == 0 ? null : options.repeat,
                  hint: widget.entry.media!.type == Enum$MediaType.ANIME
                      ? 'Rewatches'
                      : 'Rereads',
                  onIncrement: () => setState(
                    () => options =
                        options.copyWith(repeat: (options.repeat ?? 0) + 1),
                  ),
                  onDecrement: () {
                    var number = (options.repeat ?? 0) - 1;

                    if (number < 0) return;

                    setState(
                      () => options = options.copyWith(repeat: number),
                    );
                  },
                ),
              ],
            ),
          ),
          RadioListTile.adaptive(
            value: true,
            groupValue: options.private,
            toggleable: true,
            controlAffinity: ListTileControlAffinity.trailing,
            title: const Text('Private'),
            onChanged: (value) =>
                setState(() => options = options.copyWith(private: value)),
          ),
          TextField(
            maxLines: null,
            controller: textController,
            // onChanged: (value) => setState(() => ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
              labelText: 'Notes',
            ),
          )
        ],
      ),
    );
  }
}

void showMediaEditor(
  BuildContext context,
  Fragment$MediaFragment media, {
  final void Function()? onDelete,
  final void Function()? onSave,
}) {
  showDialog(
    context: context,
    builder: (context) => Dialog.fullscreen(
      child: MediaEditorDialog(
        media: media,
        onDelete: onDelete,
        onSave: onSave,
      ),
    ),
  );
}
