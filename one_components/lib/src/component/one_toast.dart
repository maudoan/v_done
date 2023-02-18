/*
 * File: one_toast.dart
 * File Created: Thursday, 17th June 2021 8:59:21 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Thursday, 17th June 2021 9:00:04 am
 * Modified By: Hieu Tran
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:one_assets/one_assets.dart';
import 'package:tuple/tuple.dart';

enum OneToastType { DEFAULT, INFO, ERROR, WARNING, SUCCESS }

enum OneToastGravity { CENTER, TOP, BOTTOM }

enum OneToastStyle { BORDER, FLAT }

class OneToast {
  OneToast._();

  static const LENGTH_SHORT = Duration(milliseconds: 1500);
  static const LENGTH_LONG = Duration(milliseconds: 2750);

  static Tuple5<Color, Color, Color, String, Color> _configuration(
    OneToastType type,
    OneToastStyle style,
  ) {
    switch (style) {
      case OneToastStyle.FLAT:
        switch (type) {
          case OneToastType.DEFAULT:
            return const Tuple5(OneColors.textWhite, OneColors.default_, OneColors.default_, OneIcons.ic_info, OneColors.textWhite);
          case OneToastType.INFO:
            return const Tuple5(OneColors.textWhite, OneColors.info, OneColors.info, OneIcons.ic_info, OneColors.textWhite);
          case OneToastType.WARNING:
            return const Tuple5(OneColors.textBlack, OneColors.warning, OneColors.warning, OneIcons.ic_warning, OneColors.textBlack);
          case OneToastType.ERROR:
            return const Tuple5(OneColors.textWhite, OneColors.error, OneColors.error, OneIcons.ic_error_2, OneColors.textWhite);
          case OneToastType.SUCCESS:
            return const Tuple5(OneColors.textWhite, OneColors.success, OneColors.success, OneIcons.ic_success, OneColors.textWhite);
        }
      case OneToastStyle.BORDER:
        switch (type) {
          case OneToastType.DEFAULT:
            return const Tuple5(OneColors.textBlack, OneColors.defaultLight, OneColors.borderGrey, OneIcons.ic_info, OneColors.textGrey1);
          case OneToastType.INFO:
            return const Tuple5(OneColors.brandVNP, OneColors.infoLight, OneColors.brandVNP, OneIcons.ic_info, OneColors.brandVNP);
          case OneToastType.WARNING:
            return const Tuple5(OneColors.textBlack, OneColors.warningLight, OneColors.borderYellow, OneIcons.ic_warning, OneColors.warning);
          case OneToastType.ERROR:
            return const Tuple5(OneColors.error, OneColors.errorLight, OneColors.borderRed, OneIcons.ic_error_2, OneColors.error);
          case OneToastType.SUCCESS:
            return const Tuple5(OneColors.success, OneColors.successLight, OneColors.borderGreen, OneIcons.ic_success, OneColors.success);
        }
    }
  }

  static Color _textColor(OneToastType type, OneToastStyle style) => _configuration(type, style).item1;
  static Color _background(OneToastType type, OneToastStyle style) => _configuration(type, style).item2;
  static Color _borderColor(OneToastType type, OneToastStyle style) => _configuration(type, style).item3;
  static String _iconUrl(OneToastType type, OneToastStyle style) => _configuration(type, style).item4;
  static Color _iconColor(OneToastType type, OneToastStyle style) => _configuration(type, style).item5;
  static MainAxisAlignment _alignment(OneToastGravity gravity) {
    switch (gravity) {
      case OneToastGravity.TOP:
        return MainAxisAlignment.start;
      case OneToastGravity.BOTTOM:
        return MainAxisAlignment.end;
      case OneToastGravity.CENTER:
        return MainAxisAlignment.center;
    }
  }

  static void show({
    BuildContext? context,
    required String msg,
    OneToastType type = OneToastType.DEFAULT,
    OneToastStyle style = OneToastStyle.FLAT,
    Duration duration = OneToast.LENGTH_LONG,
    OneToastGravity gravity = OneToastGravity.BOTTOM,
    int maxLines = 4,
    bool isHtml = false,
  }) {
    final textColor = _textColor(type, style);
    final background = _background(type, style);
    final borderColor = _borderColor(type, style);
    final iconUrl = _iconUrl(type, style);
    final iconColor = _iconColor(type, style);
    final alignment = _alignment(gravity);

    _showToast(
      context ?? Get.overlayContext,
      msg: msg.trim(),
      textColor: textColor,
      background: background,
      borderColor: borderColor,
      iconUrl: iconUrl,
      iconColor: iconColor,
      duration: duration,
      alignment: alignment,
      maxLines: maxLines,
      isHtml: isHtml,
    );
  }

  static void _showToast(
    BuildContext? context, {
    required String msg,
    required Color textColor,
    required Color background,
    required Color borderColor,
    required String iconUrl,
    required Color iconColor,
    required Duration duration,
    required MainAxisAlignment alignment,
    required int maxLines,
    required bool isHtml,
  }) {
    if (context == null) return;
    final _fToast = FToast();
    _fToast.init(context);

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
            msg,
            style: OneTheme.of(context).body1.copyWith(color: textColor),
            maxLines: maxLines,
            overflow: TextOverflow.fade,
          );

    final _toast = Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: borderColor),
        color: background,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: SvgPicture.asset(iconUrl, color: iconColor, cacheColorFilter: true),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: _messBody,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            color: iconColor,
            onPressed: () => _fToast.removeCustomToast(),
          )
        ],
      ),
    );
    _fToast.showToast(
      child: _toast,
      toastDuration: duration,
      positionedToastBuilder: (_, child) {
        return SafeArea(
          child: Column(
            mainAxisAlignment: alignment,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              ),
            ],
          ),
        );
      },
    );
  }
}
