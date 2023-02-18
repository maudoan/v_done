/*
 * File: floating_action_item_button.dart
 * File Created: Monday, 14th March 2022 11:58:09 pm
 * Author: Dang Quang
 * -----
 * Last Modified: Tuesday, 21st June 2022 10:01:44 am
 * Modified By: Hieu Tran
 */

import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/one_components.dart';

import 'floating_action_item_clip_path.dart';

class FloatingActionItemButton extends StatelessWidget {
  const FloatingActionItemButton({
    Key? key,
    required this.title,
    this.onTap,
    this.iconAssetPath,
    this.color,
    this.controller,
  }) : super(key: key);

  final String title;
  final String? iconAssetPath;
  final VoidCallback? onTap;
  final Color? color;
  final OneButtonController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Opacity(
        opacity: 0.9,
        child: Row(
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              decoration: const BoxDecoration(
                color: Color(0xFF141518),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title, style: OneTheme.of(context).body1.copyWith(color: Colors.white)),
              ),
            ),
            Container(
              child: ClipPath(
                clipper: FloatingActionItemClipPath(),
                child: Container(
                  height: 14,
                  width: 8,
                  color: const Color(0xFF141518),
                ),
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        width: 16,
      ),
      OneButtonIcon(
        iconAssetPath: iconAssetPath ?? OneIcons.ic_add,
        isCircle: true,
        onPressed: onTap,
        color: color,
        controller: controller,
      ),
    ]);
  }
}
