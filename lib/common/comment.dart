import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/common/gql_widget.dart';
import 'package:myaniapp/common/list_tile_circle_avatar.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/likes.graphql.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/routes.dart';
import 'package:mygraphql/graphql.dart';
import 'package:relative_time/relative_time.dart';

class Comment extends StatefulWidget {
  const Comment({
    super.key,
    required this.avatar,
    required this.username,
    required this.createdAt,
    required this.body,
    this.footer,
    this.replies,
    this.isReply = false,
    this.onTap,
    required this.collapsible,
    this.onAvatarTap,
    this.badge,
    this.decoration,
  });

  final String avatar;
  final String username;
  final int createdAt;
  final Widget body;
  final Widget? footer;
  final GestureTapCallback? onTap;
  final List<Widget>? replies;
  final bool isReply;
  final bool collapsible;
  final GestureTapCallback? onAvatarTap;
  final List<CommentBadge>? badge;
  final BoxDecoration? decoration;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    var decoration =
        widget.decoration ??
        (BoxDecoration(
          border: widget.isReply
              ? Border(
                  left: BorderSide(
                    width: 2,
                    color: context.theme.colorScheme.surfaceContainerHighest,
                  ),
                )
              : Border.symmetric(
                  horizontal: BorderSide(
                    width: 1,
                    color: context.theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
        ));

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: widget.isReply ? const EdgeInsets.only(left: 5) : null,
        decoration: decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: widget.collapsible
                  ? () => setState(() => collapsed = !collapsed)
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onAvatarTap,
                      child: ListTileCircleAvatar(url: widget.avatar),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(widget.username, maxLines: 2),
                          if (widget.badge?.isNotEmpty == true)
                            ...widget.badge!,
                          const SizedBox(width: 5),
                          Text(
                            widget.createdAt.dateFromTimestamp().relativeTime(
                              context,
                            ),
                            style: context.theme.textTheme.labelSmall?.copyWith(
                              color: context.theme.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!collapsed) widget.body,
            if (widget.footer != null && !collapsed) widget.footer!,
            if (widget.replies?.isNotEmpty == true && !collapsed)
              ...widget.replies!,
          ],
        ),
      ),
    );
  }
}

class CommentBadge extends StatelessWidget {
  const CommentBadge({super.key, required this.text});

  final List<String> text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Tooltip(
        message: text.length > 1 ? text.join("\n") : "",
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: imageRadius,
            color: context.theme.colorScheme.surfaceContainerHigh,
          ),
          child: Text(text.first, style: context.theme.textTheme.labelSmall),
        ),
      ),
    );
  }
}

class CommentLikeButton extends StatelessWidget {
  const CommentLikeButton({
    super.key,
    required this.likeCount,
    required this.isLiked,
    required this.onPressed,
    this.id,
    this.type,
  });

  final int likeCount;
  final bool isLiked;
  final VoidCallback onPressed;
  final int? id;
  final Enum$LikeableType? type;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(likeCount.abbreviate()),
      icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          isLiked ? Colors.red : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      onPressed: onPressed,
      onLongPress: (id == null || type == null)
          ? null
          : () => showModalBottomSheet(
              context: context,
              builder: (context) => LikesSheet(id: id!, type: type!),
            ),
    );
  }
}

class LikesSheet extends HookWidget {
  const LikesSheet({super.key, required this.id, required this.type});

  final int id;
  final Enum$LikeableType type;

  @override
  Widget build(BuildContext context) {
    final (:fetchMore, :refetch, :snapshot) = gqlClient.useQuery(
      GQLRequest(
        likesQuery,
        variables: Variables$Query$Likes(id: id, type: type).toJson(),
        parseData: Query$Likes.fromJson,
        mergeResults: defaultMergeResults('Page.likes'),
      ),
    );

    return GQLWidget(
      refetch: refetch,
      response: snapshot,
      builder: () => PaginationView.list(
        pageInfo: snapshot.parsedData!.Page!.pageInfo!,
        req: (nextPage) => fetchMore(
          variables: Variables$Query$Likes.fromJson(
            snapshot.request!.variables,
          ).copyWith(page: nextPage).toJson(),
        ),
        itemCount: snapshot.parsedData!.Page!.likes!.length,
        itemBuilder: (context, index) {
          final like = snapshot.parsedData!.Page!.likes![index]!;

          return ListTile(
            title: Text(like.name!),
            leading: ListTileCircleAvatar(url: like.avatar!.large!),
            onTap: () => context.push(Routes.user(like.name)),
          );
        },
      ),
    );
  }
}
