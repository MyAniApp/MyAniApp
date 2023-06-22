import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';

class Pagination extends StatelessWidget {
  const Pagination({
    super.key,
    required this.child,
    required this.pageInfo,
    required this.opts,
    required this.fetchMore,
  });

  final Widget child;
  final FetchMoreOptions opts;
  final Fragment$PageInfo pageInfo;
  final FetchMore fetchMore;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >
                notification.metrics.maxScrollExtent - 100 &&
            pageInfo.hasNextPage == true) {
          fetchMore(opts);
        }
        return false;
      },
      child: child,
    );
  }
}
