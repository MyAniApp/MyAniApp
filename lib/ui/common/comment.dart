import 'package:flutter/material.dart';
import 'package:myaniapp/ui/common/image.dart';
import 'package:myaniapp/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    required this.body,
    this.avatarUrl,
    this.username,
    this.isReply = false,
    this.footer,
    this.replies,
    this.onTap,
    this.createdAt,
    this.leading,
  });

  final String? avatarUrl;
  final Widget body;
  final int? createdAt;
  final Widget? footer;
  final bool isReply;
  final Widget? leading;
  final VoidCallback? onTap;
  final List<Widget>? replies;
  final String? username;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(),
      overflow: TextOverflow.ellipsis,
      child: Card(
        shadowColor: Colors.transparent,
        margin: isReply ? const EdgeInsets.fromLTRB(5, 5, 0, 5) : null,
        child: InkWell(
          onTap: onTap,
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Container(
              decoration: isReply
                  ? BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          width: 3,
                        ),
                      ),
                    )
                  : null,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 10),
                      child: CommentHeader(
                        avatarUrl: avatarUrl,
                        username: username,
                        createdAt: createdAt,
                        leading: leading,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 10),
                      child: body,
                    ),
                    if (footer != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 15, left: 10),
                        child: footer!,
                      ),
                    if (replies != null)
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) => replies![index],
                        itemCount: replies!.length,
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommentHeader extends StatelessWidget {
  const CommentHeader({
    super.key,
    required this.username,
    required this.avatarUrl,
    this.createdAt,
    this.leading,
  });

  final String? avatarUrl;
  final int? createdAt;
  final Widget? leading;
  final String? username;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Row(
      children: [
        if (avatarUrl != null)
          GestureDetector(
            child: CImage(
              imageUrl: avatarUrl!,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (username != null) Text(username!),
              if (createdAt != null)
                Text(
                  timeago.format(
                    dateFromTimestamp(createdAt!),
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        if (leading != null) ...[const Spacer(), leading!],
      ],
    );
  }
}
