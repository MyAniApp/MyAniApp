import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/common/list_tile_circle_avatar.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/fragments/thread.graphql.dart';
import 'package:myaniapp/routes.dart';
import 'package:relative_time/relative_time.dart';

class ThreadCard extends StatelessWidget {
  const ThreadCard({super.key, required this.thread});

  final Fragment$ThreadFragment thread;

  @override
  Widget build(BuildContext context) {
    if (thread.isSticky == true) {
      return Card(
        child: InkWell(
          onTap: () => context.push(
            Routes.thread(thread.id),
            extra: {'placeholder': thread},
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 5,
              children: [
                Icon(Icons.push_pin_outlined),
                Flexible(
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      Text(thread.title!, maxLines: 2, overflow: .ellipsis),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.remove_red_eye_outlined),
                            SizedBox(width: 2),
                            Text((thread.replyCount ?? 0).abbreviate()),
                            SizedBox(width: 10),
                            Icon(Icons.mode_comment_outlined),
                            SizedBox(width: 2),
                            Text((thread.replyCount ?? 0).abbreviate()),
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
      );
    }

    return Card(
      child: InkWell(
        onTap: () => context.push(
          Routes.thread(thread.id),
          extra: {'placeholder': thread},
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                thread.title!.trim(),
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: .ellipsis,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.remove_red_eye_outlined),
                    SizedBox(width: 2),
                    Text((thread.replyCount ?? 0).abbreviate()),
                    SizedBox(width: 10),
                    Icon(Icons.mode_comment_outlined),
                    SizedBox(width: 2),
                    Text((thread.replyCount ?? 0).abbreviate()),
                  ],
                ),
              ),
              Wrap(
                crossAxisAlignment: .center,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: ListTileCircleAvatar(
                      url:
                          thread.replyUser?.avatar?.large ??
                          anilistDefaultImage,
                    ),
                  ),
                  SizedBox(width: 5),
                  if (thread.replyUser != null)
                    Text(
                      '${thread.replyUser!.name} replied ${thread.repliedAt!.dateFromTimestamp().relativeTime(context)}',
                    )
                  else
                    Text(
                      '${thread.user!.name} created ${thread.repliedAt!.dateFromTimestamp().relativeTime(context)}',
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Row(
                    children: [
                      for (var category in thread.categories!)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Chip(label: Text(category!.name)),
                        ),
                      for (var media in thread.mediaCategories!)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Chip(
                            label: Text(media!.title!.userPreferred!),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
