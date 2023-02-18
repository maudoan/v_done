/*
 * File: one_button_controller.dart
 * File Created: Friday, 26th February 2021 12:24:41 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 26th February 2021 12:26:43 am
 * Modified By: Hieu Tran
 */

part of 'one_button.dart';

class OneButtonController extends ValueNotifier<OneButtonValue> {
  OneButtonController({
    bool enable = true,
    OneButtonState state = OneButtonState.primary,
    String? label,
    OneVisibility visibility = OneVisibility.VISIBLE,
  }) : super(OneButtonValue(
          enable: enable,
          state: state,
          label: label,
          visibility: visibility,
        ));

  OneButtonController.fromValue(OneButtonValue value) : super(value);

  bool get enable => value.enable;
  OneButtonState get state => value.state;
  String? get label => value.label;
  OneVisibility get visibility => value.visibility;

  set enable(bool enable) => value = value.copyWith(enable: enable);
  set state(OneButtonState state) => value = value.copyWith(state: state);
  set label(String? label) => value = value.copyWith(label: label);
  set visibility(OneVisibility visibility) => value = value.copyWith(visibility: visibility);

  @override
  set value(OneButtonValue newValue) {
    super.value = newValue;
  }
}
