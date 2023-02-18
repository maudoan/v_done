/*
 * File: one_background_login.dart
 * File Created: Monday, 22nd February 2021 10:33:25 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 22nd February 2021 10:34:23 am
 * Modified By: Hieu Tran
 */

import 'package:flutter/material.dart';

import 'one_background.dart';
import 'one_background_clipper.dart';

class OneBackgroundLogin extends StatelessWidget {
  const OneBackgroundLogin({
    Key? key,
    this.height = 210,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final edgeInsets = MediaQuery.of(context).padding;
    return OneBackground(
      height: height + edgeInsets.top,
      clipper: OneBackgroundClipper(
        edgeInsets.top / 2,
        0.3,
        20,
        80,
      ),
    );
  }
}
