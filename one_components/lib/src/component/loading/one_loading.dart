/*
 * File: one_loading.dart
 * File Created: Saturday, 17th April 2021 11:52:35 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Saturday, 17th April 2021 11:52:42 am
 * Modified By: Hieu Tran
 */

// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/src/3rd/flutter_spinkit/flutter_spinkit.dart';

const String _kTitleText = 'Thông báo';
const String _kText = 'Vui lòng đợi ...';

class OneLoading extends StatelessWidget {
  const OneLoading({
    Key? key,
    this.barrierColor = Colors.black54,
    this.title = _kTitleText,
    this.text = _kText,
    this.barrierDismissible = false,
    this.onForegroundGained,
  }) : super(key: key);

  final Color barrierColor;
  final String title;
  final String text;
  final bool barrierDismissible;
  final Function()? onForegroundGained;

  static void show({
    bool barrierDismissible = false,
    void Function()? onForegroundGained,
  }) {
    if (Get.isDialogOpen == false) {
      Get.dialog(
        OneLoading(
          barrierDismissible: barrierDismissible,
          onForegroundGained: onForegroundGained,
        ),
        barrierDismissible: barrierDismissible,
      );
    }
  }

  static void showWith({
    String title = _kTitleText,
    required String text,
    bool barrierDismissible = false,
    void Function()? onForegroundGained,
  }) {
    if (Get.isDialogOpen == false) {
      Get.dialog(
        OneLoading(
          title: title,
          text: text,
          barrierDismissible: barrierDismissible,
          onForegroundGained: onForegroundGained,
        ),
        barrierDismissible: barrierDismissible,
      );
    }
  }

  static void dismiss() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildProgress(context);
  }

  Widget _buildProgress(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(barrierDismissible),
      child: FocusDetector(
        // onFocusLost: () {
        //   log('onFocusLost');
        // },
        // onFocusGained: () {
        //   log('onFocusGained');
        // },
        // onVisibilityLost: () {
        //   log('onVisibilityLost');
        // },
        // onVisibilityGained: () {
        //   log('onVisibilityGained');
        // },
        // onForegroundLost: () {
        //   log('onForegroundLost');
        // },
        onForegroundGained: () {
          // log('onForegroundGained');
          if (onForegroundGained != null) onForegroundGained!();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    // decoration: const BoxDecoration(
                    //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    //   color: OneColors.brandAneed,
                    // ),
                    child: Column(
                      children: [
                        Lottie.asset(
                          'assets/loading.json',
                          width: 100,
                          height: 100,
                          animate: true,
                          repeat: true,
                          fit: BoxFit.contain,
                        ),
                        DefaultTextStyle(
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
                          child: Text(text, textAlign: TextAlign.center),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
