/*
 * File: one_datetime_textfield_controller.dart
 * File Created: Friday, 15th October 2021 8:15:54 am
 * Author: Ha Thanh Tan
 * -----
 * Last Modified: Friday, 15th October 2021 10:15:07 am
 * Modified By: Hieu Tran
 */

part of 'one_datetime_textfield.dart';

class OneDateTimeController extends ValueNotifier<OneDateTimeValue> {
  OneDateTimeController({
    DateTime? dateTime,
    bool isEnable = true,
  }) : super(OneDateTimeValue(
          dateTime: dateTime,
          isEnable: isEnable,
        ));

  OneDateTimeController.fromValue(OneDateTimeValue value) : super(value);

  DateTime? get dateTime => value.dateTime;
  String? get errorText => value.errorText?.trim();
  bool get isEnable => value.isEnable;

  set dateTime(DateTime? dateTime) => value = value.copyWith(dateTime: dateTime);
  set errorText(String? errorText) => value = value.copyWith(errorText: errorText?.trim());
  set isEnable(bool isEnable) => value = value.copyWith(isEnable: isEnable);

  late ValueGetter<bool> validate;
  late Function({String? errorText}) shake;

  @override
  set value(OneDateTimeValue newValue) {
    super.value = newValue;
  }
}
