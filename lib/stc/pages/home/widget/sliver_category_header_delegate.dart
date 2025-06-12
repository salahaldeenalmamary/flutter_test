import 'package:flutter/material.dart';

import '../../../theme/app_styles.dart';

class SliverCategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverCategoryHeaderDelegate({required this.child});

 
  final double _height = 50.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: ColorTheme.background,
      child: child,
    );
  }

  @override
  double get maxExtent => _height;

  @override
  double get minExtent => _height;

  @override
  bool shouldRebuild(covariant SliverCategoryHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
