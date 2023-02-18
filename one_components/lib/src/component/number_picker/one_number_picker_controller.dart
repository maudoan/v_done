/*
 * File: one_number_picker_controller.dart
 * File Path: c:\PTPM1_IT_OneApp\one_components\lib\src\component\number_picker\one_number_picker_controller.dart
 * File Created: Wednesday, 31/03/2021 11:56:37
 * Author: Lê Nguyên Trà (traln@Aneed.vn)
 * -----
 * Last Modified: Friday, 02/04/2021 08:42:08
 * Modified By: Hieu Tran
 * -----
 * Copyright OneBSS - 2021 , Trung tâm Aneed - IT3
 */

part of 'one_number_picker.dart';

class OneNumberPickerController extends ValueNotifier<OneNumberPickerValue> {
  OneNumberPickerController({
    double number = 1,
    bool enable = true,
    OneVisibility visibility = OneVisibility.VISIBLE,
  }) : super(OneNumberPickerValue(
          number: number,
          enable: enable,
          visibility: visibility,
        ));

  OneNumberPickerController.fromValue(OneNumberPickerValue value) : super(value);

  double get number => value.number;
  bool get enable => value.enable;
  OneVisibility get visibility => value.visibility;

  set number(double number) => value = value.copyWith(number: number);
  set enable(bool enable) => value = value.copyWith(enable: enable);
  set visibility(OneVisibility visibility) => value = value.copyWith(visibility: visibility);

  @override
  set value(OneNumberPickerValue newValue) {
    super.value = newValue;
  }
}
