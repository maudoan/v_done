/*
 * File: one_search_controller.dart
 * File Created: Monday, 15th March 2021 2:17:22 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 15th March 2021 2:21:49 pm
 * Modified By: Hieu Tran
 */

part of 'one_search_field.dart';

class OneSearchController extends ValueNotifier<OneSearchValue> {
  OneSearchController({
    String text = '',
    bool enable = true,
    OneVisibility visibility = OneVisibility.VISIBLE,
  }) : super(OneSearchValue(
          text: text,
          enable: enable,
          visibility: visibility,
        ));

  OneSearchController.fromValue(OneSearchValue value) : super(value);

  String get text => value.text.trim();
  bool get enable => value.enable;
  OneVisibility get visibility => value.visibility;

  set text(String text) => value = value.copyWith(text: text.trim());
  set enable(bool enable) => value = value.copyWith(enable: enable);
  set visibility(OneVisibility visibility) => value = value.copyWith(visibility: visibility);

  @override
  set value(OneSearchValue newValue) {
    super.value = newValue;
  }

  void clear() => text = '';
}
