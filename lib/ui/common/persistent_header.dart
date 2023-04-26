import 'package:flutter/material.dart';

class SliverPersistentHeaderTabBarDelegate
    extends SliverPersistentHeaderDelegate {
  SliverPersistentHeaderTabBarDelegate(
    this._tabBar, {
    this.addHeight = 0,
  });

  final double addHeight;

  final TabBar _tabBar;

  @override
  double get maxExtent => _tabBar.preferredSize.height + addHeight;

  @override
  double get minExtent => _tabBar.preferredSize.height + addHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 1,
      child: Container(
        margin: EdgeInsets.only(top: addHeight),
        // height: _tabBar.preferredSize.height + addHeight,
        child: _tabBar,
      ),
    );
  }
}
