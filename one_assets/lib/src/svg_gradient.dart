/*
 * File: svg_gradient.dart
 * File Created: Thursday, 25th February 2021 9:26:10 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Thursday, 25th February 2021 9:26:40 am
 * Modified By: Hieu Tran
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'theme/one_colors.dart';

class SvgGradient extends StatelessWidget {
  const SvgGradient(
    this.iconAssetPath, {
    Key? key,
    this.gradient = OneColors.gradient,
    this.color = Colors.white,
    this.width,
    this.height,
  }) : super(key: key);

  final String iconAssetPath;
  final Gradient gradient;
  final Color color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: SvgPicture.asset(
        iconAssetPath,
        color: color,
        cacheColorFilter: true,
        height: height ?? 30,
        width: width ?? 30,
      ),
    );
  }
}
