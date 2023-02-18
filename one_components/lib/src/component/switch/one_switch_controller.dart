/*
 * File: one_switch_controller.dart
 * File Created: Friday, 7th May 2021 9:29:23 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 7th May 2021 9:32:40 am
 * Modified By: Hieu Tran
 */

part of 'one_switch.dart';

class OneSwitchController extends ValueNotifier<OneSwitchValue> {
  OneSwitchController({
    bool enable = true,
    bool selected = false,
    String? label,
    OneVisibility visibility = OneVisibility.VISIBLE,
  }) : super(OneSwitchValue(
          enable: enable,
          selected: selected,
          label: label,
          visibility: visibility,
        ));

  OneSwitchController.fromValue(OneSwitchValue value) : super(value);

  bool get enable => value.enable;
  bool get selected => value.selected;
  String? get label => value.label;
  OneVisibility get visibility => value.visibility;

  set enable(bool enable) => value = value.copyWith(enable: enable);
  set selected(bool? selected) => value = value.copyWith(selected: selected);
  set label(String? label) => value = value.copyWith(label: label);
  set visibility(OneVisibility visibility) => value = value.copyWith(visibility: visibility);

  @override
  set value(OneSwitchValue newValue) {
    super.value = newValue;
  }
}
