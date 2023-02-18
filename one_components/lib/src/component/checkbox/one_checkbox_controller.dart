/*
 * File: one_checkbox_controller.dart
 * File Created: Friday, 26th February 2021 1:51:16 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 26th February 2021 1:53:46 pm
 * Modified By: Hieu Tran
 */
part of 'one_checkbox.dart';

class OneCheckboxController extends ValueNotifier<OneCheckboxValue> {
  OneCheckboxController({
    bool enable = true,
    bool selected = false,
    String? label,
    OneVisibility visibility = OneVisibility.VISIBLE,
  }) : super(OneCheckboxValue(
          enable: enable,
          selected: selected,
          label: label,
          visibility: visibility,
        ));

  OneCheckboxController.fromValue(OneCheckboxValue value) : super(value);

  bool get enable => value.enable;
  bool get selected => value.selected;
  String? get label => value.label;
  OneVisibility get visibility => value.visibility;

  set enable(bool enable) => value = value.copyWith(enable: enable);
  set selected(bool? selected) => value = value.copyWith(selected: selected);
  set label(String? label) => value = value.copyWith(label: label);
  set visibility(OneVisibility visibility) => value = value.copyWith(visibility: visibility);

  @override
  set value(OneCheckboxValue newValue) {
    super.value = newValue;
  }
}
