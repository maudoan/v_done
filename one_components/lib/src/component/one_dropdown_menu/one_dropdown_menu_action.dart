/*
 * File: one_dropdown_menu_action.dart
 * File Created: Tuesday, 12th October 2021 10:59:19 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Tuesday, 12th October 2021 10:59:27 am
 * Modified By: Hieu Tran
 */

part of 'one_dropdown_menu_view.dart';

class OneDropdownMenuAction {
  final int id;
  final String name;
  final String imageUrl;
  final VoidCallback? callback;

  OneDropdownMenuAction({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.callback,
  });
}
