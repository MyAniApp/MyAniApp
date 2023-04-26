import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myaniapp_v2/constants.dart';
import 'package:myaniapp_v2/graphql/__generated/graphql/fragments.graphql.dart';
import 'package:myaniapp_v2/routes.gr.dart';
import 'package:myaniapp_v2/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class ThreadCard extends StatelessWidget {
  const ThreadCard({super.key, required this.thread});

  final Fragment$Thread thread;

  @override
  Widget build(BuildContext context) {
    if (thread.isSticky == true) {
      return ListTile(
        onTap: () => context.router.push(ThreadRoute(id: thread.id)),
        title: Text(
          thread.title!,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        leading: const Icon(Icons.push_pin),
        tileColor:
            Theme.of(context).colorScheme.secondaryContainer.withAlpha(100),
        shape: RoundedRectangleBorder(borderRadius: imageRadius),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if ((thread.viewCount ?? 0) > 0) ...[
              const Icon(Icons.remove_red_eye),
              Text((thread.viewCount ?? 0).toString()),
            ],
            if ((thread.replyCount ?? 0) > 0) ...[
              const Icon(Icons.chat_bubble),
              Text((thread.replyCount ?? 0).toString()),
            ],
          ],
        ),
      );
    }

    return ListTile(
      onTap: () => context.router.push(ThreadRoute(id: thread.id)),
      title: Text(
        thread.title!,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    (thread.replyUser?.avatar?.large ??
                        thread.user!.avatar!.large!)),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: (thread.replyCount ?? 0) > 0
                              ? thread.replyUser?.name
                              : 'by'),
                      const TextSpan(text: ' '),
                      if ((thread.replyCount ?? 0) > 0)
                        TextSpan(
                            text:
                                'replied ${timeago.format(dateFromTimestamp(thread.repliedAt!))}')
                      else
                        TextSpan(text: thread.user!.name)
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              for (var category in thread.categories!)
                Chip(
                  label: Text(category!.name),
                  labelPadding: EdgeInsets.zero,
                  labelStyle: Theme.of(context).textTheme.labelSmall,
                )
            ],
          )
        ],
      ),
      tileColor:
          Theme.of(context).colorScheme.secondaryContainer.withAlpha(100),
      shape: RoundedRectangleBorder(borderRadius: imageRadius),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('hi')
          if ((thread.viewCount ?? 0) > 0) ...[
            const Icon(Icons.remove_red_eye),
            Text((thread.viewCount ?? 0).toString()),
          ],
          if ((thread.replyCount ?? 0) > 0) ...[
            const Icon(Icons.chat_bubble),
            Text((thread.replyCount ?? 0).toString()),
          ],
        ],
      ),
    );
  }
}
