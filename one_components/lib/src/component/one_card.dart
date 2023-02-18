/*
 * File: one_card.dart
 * File Created: Monday, 28th June 2021 5:05:31 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 28th June 2021 5:06:00 pm
 * Modified By: Hieu Tran
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';

class OneCard extends StatelessWidget {
  const OneCard({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.gradient,
    this.borderRadius,
    this.padding,
    this.margin,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final Gradient? gradient;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned.fill(
            top: 10.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                boxShadow: [
                  BoxShadow(
                    color: OneColors.shadow.withOpacity(0.2),
                    blurRadius: 20.0,
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                padding: padding,
                decoration: BoxDecoration(
                  color: color,
                  gradient: gradient,
                  borderRadius: borderRadius,
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
