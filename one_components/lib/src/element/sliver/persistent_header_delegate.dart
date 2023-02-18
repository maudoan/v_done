/*
 * File: persistent_header_delegate.dart
 * File Created: Wednesday, 24th March 2021 1:27:29 pm
 * Author: Dương Trí
 * -----
 * Last Modified: Wednesday, 24th March 2021 1:27:55 pm
 * Modified By: Dương Trí
 */

import 'dart:math' as math;
import 'package:flutter/material.dart';

class PersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  PersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    this.color,
  });
  final double minHeight;
  final double maxHeight;
  final Color? color;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
        child: Container(
      color: color,
      child: child,
    ));
  }

  @override
  bool shouldRebuild(PersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
