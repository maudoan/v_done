/*
 * File: wave_clipper.dart
 * File Created: Friday, 19th March 2021 11:10:22 am
 * Author: Dương Trí
 * -----
 * Last Modified: Friday, 19th March 2021 11:10:26 am
 * Modified By: Dương Trí
 */

import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.quadraticBezierTo(size.width * .5, size.height * 1.5, size.width, 0);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
