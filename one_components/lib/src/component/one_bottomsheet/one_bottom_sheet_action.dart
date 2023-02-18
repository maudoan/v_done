/*
 * File: one_bottom_sheet_action.dart
 * File Created: Thursday, 15th April 2021 5:16:22 pm
 * Author: Do Truong Son
 * -----
 * Last Modified: Hà Thanh Tân
 * Modified By: Hà Thanh Tân
 */

part of 'one_bottom_sheet.dart';

class OneBottomSheetAction {
  final int id;
  final String? name;
  final bool isEnable;

  final String imageUrl;
  final VoidCallback? callback;
  final Tuple2<String?, List<OneBottomSheetAction>>? child;

  OneBottomSheetAction({
    required this.id,
    this.name,
    this.isEnable = true,
    required this.imageUrl,
    this.callback,
    this.child,
  }) : assert(!(callback != null && child != null));
}
