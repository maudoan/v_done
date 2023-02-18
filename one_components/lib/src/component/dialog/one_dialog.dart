/*
 * File: one_dialog.dart
 * File Created: Tuesday, 6th April 2021 3:51:49 pm
 * Author: Tân Hà
 * -----
 * Last Modified: Tuesday, 6th April 2021 3:51:57 pm
 * Modified By: Hieu Tran
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:one_assets/one_assets.dart';
import 'package:one_components/src/component/button/one_button.dart';

enum OneDialogAlertStyle {
  none,
  success,
  failure,
}

class OneDialog extends StatefulWidget {
  const OneDialog({
    Key? key,
    this.alertStyle = OneDialogAlertStyle.none,
    this.title = 'Thông báo',
    this.msg,
    this.okText = 'Đóng',
    this.cancelText,
    this.okHandler,
    this.cancelHandler,
    this.closeHandler,
    this.content,
    this.titleTextAlign = TextAlign.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.msgTextAlign = TextAlign.center,
    this.barrierDismissible = false,
    this.okBtnAutoPopWhenOnTap = true,
    this.cancelBtnAutoPopWhenOnTap = true,
    this.isBtnCanclePrimary = false,
  }) : super(key: key);

  final OneDialogAlertStyle alertStyle;
  final CrossAxisAlignment crossAxisAlignment;
  final String title;
  final String? msg;
  final String okText;
  final String? cancelText;
  final VoidCallback? okHandler;
  final VoidCallback? cancelHandler;
  final VoidCallback? closeHandler;
  final Widget? content;
  final TextAlign titleTextAlign;
  final TextAlign msgTextAlign;
  final bool barrierDismissible;
  final bool okBtnAutoPopWhenOnTap;
  final bool cancelBtnAutoPopWhenOnTap;
  final bool isBtnCanclePrimary;
  @override
  _OneDialogState createState() => _OneDialogState();

  static Future<void> show(
    BuildContext context, {
    OneDialogAlertStyle alertStyle = OneDialogAlertStyle.none,
    String title = 'Thông báo',
    String? msg,
    String okText = 'Đóng',
    String? cancelText,
    VoidCallback? okHandler,
    VoidCallback? cancelHandler,
    VoidCallback? closeHandler,
    Widget? content,
    TextAlign titleTextAlign = TextAlign.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextAlign msgTextAlign = TextAlign.center,
    bool barrierDismissible = false,
    bool okBtnAutoPopWhenOnTap = true,
    bool cancelBtnAutoPopWhenOnTap = true,
    bool isBtnCanclePrimary = false,
  }) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return OneDialog(
          alertStyle: alertStyle,
          title: title,
          msg: msg,
          okText: okText,
          cancelText: cancelText,
          okHandler: okHandler,
          cancelHandler: cancelHandler,
          closeHandler: closeHandler,
          content: content,
          titleTextAlign: titleTextAlign,
          crossAxisAlignment: crossAxisAlignment,
          msgTextAlign: msgTextAlign,
          barrierDismissible: barrierDismissible,
          okBtnAutoPopWhenOnTap: okBtnAutoPopWhenOnTap,
          cancelBtnAutoPopWhenOnTap: cancelBtnAutoPopWhenOnTap,
        );
      },
    );
  }
}

class _OneDialogState extends State<OneDialog> {
  String? get _alertImgUrl {
    switch (widget.alertStyle) {
      case OneDialogAlertStyle.success:
        return OneImages.alert_success;
      case OneDialogAlertStyle.failure:
        return OneImages.alert_failure;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(widget.barrierDismissible),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 2,
        child: KeyboardDismissOnTap(
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    constraints: BoxConstraints(maxHeight: constraints.maxHeight * 0.8),
                    margin: const EdgeInsets.only(top: 15, bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: widget.crossAxisAlignment,
                                children: [
                                  _buildAlertImg(context),
                                  _buildTitle(context),
                                  const SizedBox(height: 5),
                                  _buildBody(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildBtns(),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                top: 10,
                right: 10,
                child: _buildBtnClose(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertImg(context) {
    if (_alertImgUrl == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 15),
      child: Center(
        child: Image.asset(_alertImgUrl!),
      ),
    );
  }

  Widget _buildTitle(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: SelectableText(
        widget.title,
        style: OneTheme.of(context).header,
        textAlign: widget.titleTextAlign,
      ),
    );
  }

  Widget _buildBody() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.msg != null)
              SelectableText(
                widget.msg!,
                style: OneTheme.of(context).title2.copyWith(color: OneColors.textGrey2),
                textAlign: widget.msgTextAlign,
              ),
            widget.content ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildBtns() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          if (widget.cancelText != null || widget.cancelHandler != null) ...[
            Expanded(
              child: OneButton(
                label: widget.cancelText ?? 'Thôi',
                controller: OneButtonController(state: widget.isBtnCanclePrimary ? OneButtonState.primary : OneButtonState.outline),
                onPressed: () {
                  if (widget.cancelBtnAutoPopWhenOnTap) Navigator.pop(context, false);
                  if (widget.cancelHandler != null) {
                    widget.cancelHandler!();
                  }
                },
              ),
            ),
            const SizedBox(width: 20)
          ],
          Expanded(
            child: OneButton(
              label: widget.okText,
              onPressed: () {
                if (widget.okBtnAutoPopWhenOnTap) Navigator.pop(context, true);
                if (widget.okHandler != null) {
                  widget.okHandler!();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBtnClose(BuildContext context) {
    if (widget.closeHandler != null) {
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SvgPicture.asset(OneIcons.ic_cancel, color: OneColors.textGrey2),
        ),
        onTap: () {
          Navigator.of(context).pop();
          widget.closeHandler!();
        },
      );
    } else {
      return const SizedBox();
    }
  }
}
