import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';

class Pagination extends StatelessWidget {
  Pagination({
    super.key,
    required this.child,
    required this.pageInfo,
    required this.opts,
    required this.fetchMore,
    this.isLoading,
    this.depth,
  });

  final Widget child;
  final FetchMoreOptions opts;
  final Fragment$PageInfo pageInfo;
  final FetchMore fetchMore;
  final int? depth;
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        print(notification.depth);
        if (depth != null && notification.depth != depth) return false;

        if (notification.metrics.pixels >
                notification.metrics.maxScrollExtent - 100 &&
            pageInfo.hasNextPage == true &&
            (isLoading == false || isLoading == null)) {
          isLoading = true;
          fetchMore(opts);
        }
        return false;
      },
      child: child,
    );
  }
}

class GrapgqlPagination extends StatelessWidget {
  GrapgqlPagination({
    super.key,
    required this.pageInfo,
    this.depth,
    required this.fetchMore,
    required this.child,
  });

  final Fragment$PageInfo pageInfo;
  final int? depth;
  final void Function(int page) fetchMore;
  final Widget child;
  bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        if (depth != null && notification.depth != depth) return false;

        if (notification.metrics.pixels >
                notification.metrics.maxScrollExtent * .95 &&
            pageInfo.hasNextPage == true &&
            (isLoading == false || isLoading == null)) {
          isLoading = true;
          fetchMore((pageInfo.currentPage ?? 1) + 1);
        }
        return false;
      },
      child: child,
    );
  }
}
