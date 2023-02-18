/*
 * File: one_snackbar.dart
 * File Created: Monday, 21st June 2021 6:00:21 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 28th June 2021 12:47:38 pm
 * Modified By: Hieu Tran
 */

import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:one_assets/one_assets.dart';
import 'package:tuple/tuple.dart';

enum OneSnackBarType { DEFAULT, INFO, ERROR, WARNING, SUCCESS }

enum OneSnackBarStyle { BORDER, FLAT }

class OneSnackBar {
  OneSnackBar._();

  static const LENGTH_SHORT = Duration(milliseconds: 1500);
  static const LENGTH_LONG = Duration(milliseconds: 2750);

  static Tuple5<Color, Color, Color, String, Color> _configuration(
    OneSnackBarType type,
    OneSnackBarStyle style,
  ) {
    switch (style) {
      case OneSnackBarStyle.FLAT:
        switch (type) {
          case OneSnackBarType.DEFAULT:
            return const Tuple5(OneColors.textWhite, OneColors.default_, OneColors.default_, OneIcons.ic_info, OneColors.textWhite);
          case OneSnackBarType.INFO:
            return const Tuple5(OneColors.textWhite, OneColors.info, OneColors.info, OneIcons.ic_info, OneColors.textWhite);
          case OneSnackBarType.WARNING:
            return const Tuple5(OneColors.textBlack, OneColors.warning, OneColors.warning, OneIcons.ic_warning, OneColors.textBlack);
          case OneSnackBarType.ERROR:
            return const Tuple5(OneColors.textWhite, OneColors.error, OneColors.error, OneIcons.ic_error_2, OneColors.textWhite);
          case OneSnackBarType.SUCCESS:
            return const Tuple5(OneColors.textWhite, OneColors.success, OneColors.success, OneIcons.ic_success, OneColors.textWhite);
        }
      case OneSnackBarStyle.BORDER:
        switch (type) {
          case OneSnackBarType.DEFAULT:
            return const Tuple5(OneColors.textBlack, OneColors.defaultLight, OneColors.borderGrey, OneIcons.ic_info, OneColors.textGrey1);
          case OneSnackBarType.INFO:
            return const Tuple5(OneColors.brandVNP, OneColors.infoLight, OneColors.brandVNP, OneIcons.ic_info, OneColors.brandVNP);
          case OneSnackBarType.WARNING:
            return const Tuple5(OneColors.textBlack, OneColors.warningLight, OneColors.borderYellow, OneIcons.ic_warning, OneColors.warning);
          case OneSnackBarType.ERROR:
            return const Tuple5(OneColors.error, OneColors.errorLight, OneColors.borderRed, OneIcons.ic_error_2, OneColors.error);
          case OneSnackBarType.SUCCESS:
            return const Tuple5(OneColors.success, OneColors.successLight, OneColors.borderGreen, OneIcons.ic_success, OneColors.success);
        }
    }
  }

  static Color _textColor(OneSnackBarType type, OneSnackBarStyle style) => _configuration(type, style).item1;
  static Color _background(OneSnackBarType type, OneSnackBarStyle style) => _configuration(type, style).item2;
  static Color _borderColor(OneSnackBarType type, OneSnackBarStyle style) => _configuration(type, style).item3;
  static String _iconUrl(OneSnackBarType type, OneSnackBarStyle style) => _configuration(type, style).item4;
  static Color _iconColor(OneSnackBarType type, OneSnackBarStyle style) => _configuration(type, style).item5;

  static void show(
    BuildContext context, {
    required String msg,
    OneSnackBarType type = OneSnackBarType.DEFAULT,
    OneSnackBarStyle style = OneSnackBarStyle.FLAT,
    Duration duration = OneSnackBar.LENGTH_LONG,
    int maxLines = 4,
    bool isHtml = false,
  }) {
    final textColor = _textColor(type, style);
    final background = _background(type, style);
    final borderColor = _borderColor(type, style);
    final iconUrl = _iconUrl(type, style);
    final iconColor = _iconColor(type, style);
    late Flushbar flushBar;
    final dissmissBtn = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          flushBar.dismiss();
        },
        child: Ink(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(OneIcons.ic_cancel, color: iconColor, cacheColorFilter: true),
        ),
      ),
    );
    final _messBody = isHtml
        ? Html(
            data: '<span>$msg<span>',
            shrinkWrap: true,
            style: {
              'span': Style(
                fontSize: FontSize.medium,
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            },
          )
        : AutoSizeText(
            msg.trim(),
            style: OneTheme.of(context).body1.copyWith(color: textColor),
            maxLines: maxLines,
            overflow: TextOverflow.fade,
          );
    flushBar = Flushbar(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.all(4),
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconUrl, color: iconColor, cacheColorFilter: true),
          const SizedBox(width: 8),
          Expanded(
            child: _messBody,
          ),
        ],
      ),
      backgroundColor: background,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      borderColor: borderColor,
      borderWidth: 1.0,
      duration: duration,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      mainButton: dissmissBtn,
    );
    flushBar.show(context);
  }
}
