/*
 * File: floating_action_item_clip_path.dart
 * File Created: Monday, 14th March 2022 11:58:09 pm
 * Author: Dang Quang
 * -----
 * Last Modified: Tuesday, 21st June 2022 10:02:30 am
 * Modified By: Hieu Tran
 */

import 'package:flutter/material.dart';

class FloatingActionItemClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final bounds = Rect.fromLTWH(0, 0, size.width, size.height);

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(bounds.width, bounds.height / 2)
      ..quadraticBezierTo(bounds.width, bounds.height / 2, bounds.width, bounds.height / 2)
      ..lineTo(0, bounds.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
