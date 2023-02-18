/*
 * File: one_subtract.dart
 * File Created: Thursday, 25th March 2021 9:00:37 am
 * Author: Dương Trí
 * -----
 * Last Modified: Thursday, 25th March 2021 9:22:12 am
 * Modified By: Dương Trí
 */

import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/src/element/clipper/wave_clipper.dart';

class OneSubtract extends StatelessWidget {
  const OneSubtract({
    Key? key,
    this.height = 30,
    this.width,
    this.color,
    this.onTap,
  }) : super(key: key);

  final double height;
  final double? width;
  final Color? color;
  final VoidCallback? onTap;

  Color get _color => color ?? OneColors.brandVNP.withOpacity(0.2);

  @override
  Widget build(BuildContext context) {
    final _width = width ?? MediaQuery.of(context).size.width / 2;
    return InkWell(
      onTap: onTap,
      child: Container(
        child: ClipPath(
          clipper: WaveClipper(),
          child: DecoratedBox(
            decoration: BoxDecoration(color: _color),
            child: SizedBox(
              height: height,
              width: _width,
            ),
          ),
        ),
      ),
    );
  }
}
