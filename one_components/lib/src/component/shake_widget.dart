/*
 * File: shake_widget.dart
 * File Created: Friday, 5th February 2021 4:29:03 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 5th February 2021 4:29:09 pm
 * Modified By: Hieu Tran
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class ShakeWidget extends StatelessWidget {
  final Widget child;
  final ShakeController controller;
  final Animation _anim;

  ShakeWidget({
    required this.child,
    required this.controller,
  }) : _anim = Tween<double>(begin: 1, end: 1200).animate(controller);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        child: child,
        builder: (context, child) => Transform(
              child: child,
              transform: Matrix4.translation(_shake(_anim.value)),
            ));
  }

  Vector3 _shake(double progress) {
    final double offset = sin(progress * pi * 10.0);
    return Vector3(offset * 4, 0.0, 0.0);
  }
}

class ShakeController extends AnimationController {
  ShakeController({required TickerProvider vsync, Duration duration = const Duration(milliseconds: 500)}) : super(vsync: vsync, duration: duration);

  Future shake() async {
    if (status == AnimationStatus.completed) {
      await reverse();
    } else {
      await forward();
    }
  }
}
