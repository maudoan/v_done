/*
 * File: one_background_clipper.dart
 * File Created: Monday, 22nd February 2021 11:05:48 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 22nd February 2021 11:05:52 am
 * Modified By: Hieu Tran
 */

import 'package:flutter/material.dart';

class OneBackgroundClipper extends CustomClipper<Path> {
  OneBackgroundClipper(this.handlePointBottomPlus, this.handlePointDxScale, this.bottomLeftClipHeight, this.bottomRightClipHeight);

  final double handlePointBottomPlus;
  final double handlePointDxScale;
  final double bottomLeftClipHeight;
  final double bottomRightClipHeight;

  @override
  Path getClip(Size size) {
    final bounds = Rect.fromLTWH(0, 0, size.width, size.height);
    final handlePoint = Offset(bounds.width * handlePointDxScale, bounds.bottom + handlePointBottomPlus);

    final backgroundPath = Path()
      ..moveTo(bounds.left, bounds.top)
      ..lineTo(bounds.left, bounds.bottom - bottomLeftClipHeight)
      ..quadraticBezierTo(handlePoint.dx, handlePoint.dy, bounds.right, bounds.bottom - bottomRightClipHeight)
      ..lineTo(bounds.topRight.dx, bounds.topRight.dy)
      ..close();

    return backgroundPath;
  }

  @override
  bool shouldReclip(OneBackgroundClipper oldClipper) {
    return handlePointBottomPlus != oldClipper.handlePointBottomPlus ||
        handlePointDxScale != oldClipper.handlePointDxScale ||
        bottomLeftClipHeight != oldClipper.bottomLeftClipHeight ||
        bottomRightClipHeight != oldClipper.bottomRightClipHeight;
  }
}
