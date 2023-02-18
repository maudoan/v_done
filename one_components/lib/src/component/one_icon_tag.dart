/*
 * File: one_icon_tag.dart
 * File Created: Thursday, 27th May 2021 1:20:38 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Thursday, 27th May 2021 1:21:21 pm
 * Modified By: Hieu Tran
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';

class OneIconTag extends StatelessWidget {
  const OneIconTag({
    Key? key,
    this.color = OneColors.brandAneed,
    required this.text,
    this.iconUrl,
    this.background = OneColors.bgTag,
    this.padding,
    this.maxLines = 1,
  }) : super(key: key);

  final Color color;
  final Color background;
  final String text;
  final String? iconUrl;
  final EdgeInsetsGeometry? padding;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconUrl != null) ...[
            SvgPicture.asset(iconUrl!, color: color, cacheColorFilter: true, width: 16, height: 16),
            const SizedBox(width: 4),
          ],
          AutoSizeText(text, style: OneTheme.of(context).caption1.copyWith(color: color), maxLines: maxLines),
        ],
      ),
    );
  }
}
