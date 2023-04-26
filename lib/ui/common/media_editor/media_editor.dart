import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp_v2/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp_v2/graphql/__generated/graphql/schema.graphql.dart';
import 'package:myaniapp_v2/providers/user.dart';
import 'package:myaniapp_v2/ui/common/media_editor/provider.dart';
import 'package:myaniapp_v2/ui/common/number_picker.dart';

class MediaEditor extends ConsumerStatefulWidget {
  const MediaEditor({
    super.key,
    required this.media,
    this.onSave,
  });

  final Fragment$Media media;
  final VoidCallback? onSave;

  @override
  ConsumerState<MediaEditor> createState() => _MediaEditorState();
}

class _MediaEditorState extends ConsumerState<MediaEditor> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // if (widget.media.notes?.isNotEmpty == true) {
    //   controller.text = widget.media.notes!;
    // }
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    var entry = ref.watch(MediaEditorProvider(widget.media));
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(MediaEditorProvider(widget.media).notifier)
                  .update(widget.onSave);
              context.router.pop();
              // entry.
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: entry == null
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Text(
                    'Status',
                    style: theme.titleMedium,
                  ),
                  DropdownSearch<Enum$MediaListStatus>(
                    items: Enum$MediaListStatus.values
                        .take(Enum$MediaListStatus.values.length - 1)
                        .toList(),
                    itemAsString: (item) {
                      if (item == Enum$MediaListStatus.CURRENT) {
                        return 'Watching';
                      } else if (item == Enum$MediaListStatus.PLANNING) {
                        return 'Planning';
                      } else if (item == Enum$MediaListStatus.COMPLETED) {
                        return 'Completed';
                      } else if (item == Enum$MediaListStatus.PAUSED) {
                        return 'Paused';
                      } else if (item == Enum$MediaListStatus.DROPPED) {
                        return 'Dropped';
                      } else if (item == Enum$MediaListStatus.REPEATING) {
                        return 'Repeating';
                      }

                      return item.name;
                    },
                    selectedItem: entry.status,
                    onChanged: (value) => ref
                        .read(mediaEditorProvider(widget.media).notifier)
                        .modify(status: value),
                  ),
                  Text(
                    'Score',
                    style: theme.titleMedium,
                  ),
                  Builder(
                    builder: (context) {
                      late double max;
                      late double min;
                      double increment = 1;

                      switch (user.value!.mediaListOptions!.scoreFormat!) {
                        case Enum$ScoreFormat.POINT_100:
                          max = 100;
                          min = 0;
                          break;
                        case Enum$ScoreFormat.POINT_10_DECIMAL:
                          max = 10;
                          min = 0;
                          increment = 0.5;
                          break;
                        case Enum$ScoreFormat.POINT_10:
                          max = 10;
                          min = 0;
                          break;
                        case Enum$ScoreFormat.POINT_5:
                          max = 5;
                          min = 0;
                          break;
                        case Enum$ScoreFormat.POINT_3:
                          max = 3;
                          min = 0;
                          break;
                        case Enum$ScoreFormat.$unknown:
                          break;
                      }

                      return NumberPicker(
                        current: entry.score ?? 0,
                        onChange: (value) => ref
                            .read(mediaEditorProvider(widget.media).notifier)
                            .modify(score: value),
                        // max: user.value!.options!.,
                        increment: increment,
                        min: min,
                        max: max,
                      );
                    },
                  ),
                  Text(
                    '${entry.media!.type == Enum$MediaType.ANIME ? 'Episode' : 'Chapter'} Progress',
                    style: theme.titleMedium,
                  ),
                  NumberPicker(
                    current: (entry.progress ?? 0).toDouble(),
                    max: (entry.media!.episodes ?? entry.media!.chapters ?? 0)
                        .toDouble(),
                    min: 0,
                    onChange: (value) => ref
                        .read(mediaEditorProvider(widget.media).notifier)
                        .modify(progress: value.toInt()),
                  ),
                  Text(
                    'Total ${entry.media!.type == Enum$MediaType.ANIME ? 'Rewatches' : 'Rereads'}',
                    style: theme.titleMedium,
                  ),
                  NumberPicker(
                    current: (entry.repeat ?? 0).toDouble(),
                    min: 0,
                    onChange: (value) => ref
                        .read(mediaEditorProvider(widget.media).notifier)
                        .modify(repeat: value.toInt()),
                  ),
                  CheckboxListTile(
                    title: const Text('Private'),
                    value: entry.private ?? false,
                    onChanged: (value) => ref
                        .read(mediaEditorProvider(widget.media).notifier)
                        .modify(private: value),
                  ),
                  Text(
                    'Notes',
                    style: theme.titleMedium,
                  ),
                  TextField(
                    controller: controller,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    maxLines: null,
                  ),
                ],
              ),
            ),
    );
  }
}

Future<bool?> showMediaEditor(
  BuildContext context,
  Fragment$Media entry, {
  VoidCallback? onSave,
}) {
  return showDialog(
    context: context,
    builder: (context) => Dialog.fullscreen(
      child: MediaEditor(
        media: entry,
        onSave: onSave,
      ),
    ),
  );
}
