/*
 * File: one_error_txt.dart
 * File Created: Thursday, 17th December 2020 10:05:14 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Thursday, 24th December 2020 12:33:45 am
 * Modified By: Hieu Tran
 */

import 'package:flutter/material.dart';

class OneErrorTxt extends StatelessWidget {
  //
  final String? message;
  final Function()? onTap;
  const OneErrorTxt({this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Text(
            message!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
