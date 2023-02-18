/*
 * File: one_radio_controller.dart
 * File Created: Monday, 1st March 2021 8:15:28 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 1st March 2021 9:38:29 pm
 * Modified By: Hieu Tran
 */

part of 'one_radio.dart';

class OneRadioController<T> extends ValueNotifier<OneRadioValue> {
  OneRadioController({
    required ValueNotifier<T> groupListenable,
    bool enable = true,
    String? label,
    OneVisibility visibility = OneVisibility.VISIBLE,
  }) : super(OneRadioValue(
          groupListenable: groupListenable,
          enable: enable,
          label: label,
          visibility: visibility,
        ));

  OneRadioController.fromValue(OneRadioValue value) : super(value);

  ValueNotifier<T?> get groupListenable => value.groupListenable as ValueNotifier<T?>;
  bool get enable => value.enable;
  String? get label => value.label;
  OneVisibility get visibility => value.visibility;

  set groupListenable(ValueNotifier<T?> groupListenable) => value = value.copyWith(groupListenable: groupListenable);
  set enable(bool enable) => value = value.copyWith(enable: enable);
  set label(String? label) => value = value.copyWith(label: label);
  set visibility(OneVisibility visibility) => value = value.copyWith(visibility: visibility);

  @override
  set value(OneRadioValue newValue) {
    super.value = newValue;
  }
}
