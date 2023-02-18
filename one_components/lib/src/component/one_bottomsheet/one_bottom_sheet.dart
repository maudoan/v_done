/*
 * File: one_bottom_sheet.dart
 * Created Date: Wednesday March 31st 2021
 * Author: Do Truong Son
 * -----
 * Last Modified: Hà Thanh Tân
 * Modified By: Hà Thanh Tân
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_assets/one_assets.dart';
import 'package:tuple/tuple.dart';

part 'one_bottom_sheet_action.dart';
part 'one_bottom_sheet_horizontion.dart';

class OneBottomSheet extends StatefulWidget {
  const OneBottomSheet({
    Key? key,
    required this.actions,
    this.label,
    this.onSelected,
    this.onTapClose,
    this.barrierDismissible = true,
    this.onSelectedAutoPopWhenOnTap = true,
    this.cancelBtnAutoPopWhenOnTap = true,
  }) : super(key: key);

  final String? label;
  final List<OneBottomSheetAction> actions;
  final ValueChanged<OneBottomSheetAction>? onSelected;
  final VoidCallback? onTapClose;
  final bool barrierDismissible;
  final bool cancelBtnAutoPopWhenOnTap;
  final bool onSelectedAutoPopWhenOnTap;

  @override
  _OneBottomSheetState createState() => _OneBottomSheetState();

  static void show(
    BuildContext context, {
    String? label,
    required List<OneBottomSheetAction> actions,
    ValueChanged<OneBottomSheetAction>? onSelected,
    VoidCallback? onTapClose,
    bool barrierDismissible = true,
    bool cancelBtnAutoPopWhenOnTap = true,
    bool onSelectedAutoPopWhenOnTap = true,
  }) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (builder) {
        return OneBottomSheet(
          label: label,
          actions: actions,
          onSelected: onSelected,
          onTapClose: onTapClose,
          barrierDismissible: barrierDismissible,
          cancelBtnAutoPopWhenOnTap: cancelBtnAutoPopWhenOnTap,
          onSelectedAutoPopWhenOnTap: onSelectedAutoPopWhenOnTap,
        );
      },
    );
  }
}

class _OneBottomSheetState extends State<OneBottomSheet> {
  bool get _hasLabel => widget.label?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => Future.value(widget.barrierDismissible),
      child: Container(
        constraints: BoxConstraints(maxHeight: height * 0.6),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!_hasLabel)
                const SizedBox()
              else ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 6, 10, 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AutoSizeText(widget.label!, style: OneTheme.of(context).title1, maxLines: 3, overflow: TextOverflow.fade),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          icon: SvgPicture.asset(OneIcons.ic_cancel),
                          onPressed: () {
                            if (widget.cancelBtnAutoPopWhenOnTap) Navigator.pop(context, true);
                            if (widget.onTapClose != null) widget.onTapClose!();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(height: 1, thickness: 2, indent: 20, endIndent: 20),
              ],
              Flexible(child: _createListView(context, widget.actions)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createListView(BuildContext context, List<OneBottomSheetAction> actions) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 15, top: _hasLabel ? 0 : 10),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: actions.length,
          itemBuilder: (BuildContext context, int index) {
            final action = actions.elementAt(index);
            return _buildAction(context, action);
          },
        ),
      ),
    );
  }

  Widget _buildAction(BuildContext context, OneBottomSheetAction action) {
    return Material(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 15),
                child: SvgPicture.asset(action.imageUrl, color: action.isEnable ? null : Colors.black26),
              ),
              AutoSizeText(
                action.name ?? '',
                style: OneTheme.of(context).body2.copyWith(color: action.isEnable ? null : Colors.black26),
              ),
            ],
          ),
        ),
        onTap: !action.isEnable
            ? null
            : () {
                if (widget.onSelectedAutoPopWhenOnTap) Navigator.of(context).pop();
                if (action.child != null) {
                  OneBottomSheet.show(
                    context,
                    label: action.child!.item1,
                    actions: action.child!.item2,
                    onSelected: widget.onSelected,
                  );
                } else {
                  if (action.callback != null) action.callback!();
                  if (widget.onSelected != null) widget.onSelected!(action);
                }
              },
      ),
    );
  }
}
