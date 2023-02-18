/*
 * File: one_text_tile.dart
 * File Created: Monday, 15th March 2021 10:53:52 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 15th March 2021 10:54:14 am
 * Modified By: Hieu Tran
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/src/shared/constant.dart';

class OneTextTile extends StatelessWidget {
  const OneTextTile({
    Key? key,
    required this.titleText,
    required this.text,
    this.labelFlex = 1,
    this.textFlex = 1,
    this.selectable = true,
    this.hasDivider = true,
    this.maxLines = 2,
    this.minLines = 1,
    this.size = OneTextSize.middle,
    this.state = OneTextState.normal,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.textAlign,
    this.titleTextAlign,
    this.textColor = OneColors.textGreyDark,
    this.padding = EdgeInsets.zero,
    this.orientation = OneOrientation.HORIZONTAL,
  }) : super(key: key);

  final String titleText;
  final String text;
  final int labelFlex;
  final int textFlex;
  final bool selectable;
  final bool hasDivider;
  final int maxLines;
  final int minLines;
  final OneTextSize size;
  final OneTextState state;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final TextAlign? textAlign;
  final TextAlign? titleTextAlign;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final OneOrientation orientation;

  TextStyle getLabelStyle(BuildContext context) {
    if (size == OneTextSize.large) {
      return OneTheme.of(context).title2.copyWith(color: OneColors.textGrey2);
    } else if (size == OneTextSize.small) {
      return OneTheme.of(context).caption2.copyWith(color: OneColors.textGrey2);
    }
    return OneTheme.of(context).body2.copyWith(color: OneColors.textGrey2);
  }

  TextStyle getTextStyle(BuildContext context) {
    if (size == OneTextSize.large) {
      return state == OneTextState.bold ? OneTheme.of(context).title1.copyWith(color: textColor) : OneTheme.of(context).title2.copyWith(color: textColor);
    } else if (size == OneTextSize.small) {
      return state == OneTextState.bold ? OneTheme.of(context).caption1.copyWith(color: textColor) : OneTheme.of(context).caption2.copyWith(color: textColor);
    }
    return state == OneTextState.bold ? OneTheme.of(context).body1.copyWith(color: textColor) : OneTheme.of(context).body2.copyWith(color: textColor);
  }

  @override
  Widget build(BuildContext context) {
    if (orientation == OneOrientation.VERTICAL) {
      return _buildVertical(context);
    }
    return _buildHorizontal(context);
  }

  Widget _buildHorizontal(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Expanded(
                flex: labelFlex,
                child: AutoSizeText(
                  titleText,
                  style: getLabelStyle(context),
                  maxLines: maxLines,
                  overflow: TextOverflow.fade,
                  textAlign: titleTextAlign,
                ),
              ),
              const SizedBox(width: 7.0),
              Expanded(
                flex: textFlex,
                child: SelectableText(
                  text,
                  enableInteractiveSelection: selectable,
                  style: getTextStyle(context),
                  maxLines: maxLines,
                  minLines: minLines,
                  textAlign: textAlign,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          if (hasDivider) const Divider(height: 1.0, color: OneColors.textGrey1),
        ],
      ),
    );
  }

  Widget _buildVertical(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          AutoSizeText(
            titleText,
            style: getLabelStyle(context),
            maxLines: maxLines,
            overflow: TextOverflow.fade,
            textAlign: titleTextAlign,
          ),
          const SizedBox(height: 3.0),
          SelectableText(
            text,
            enableInteractiveSelection: selectable,
            style: getTextStyle(context),
            maxLines: maxLines,
            minLines: minLines,
            textAlign: textAlign,
          ),
          const SizedBox(height: 5.0),
          if (hasDivider) const Divider(height: 1.0, color: OneColors.textGrey1),
        ],
      ),
    );
  }
}
