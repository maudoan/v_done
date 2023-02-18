/*
 * File: one_datetime_textfield_value.dart
 * File Created: Friday, 15th October 2021 8:15:54 am
 * Author: Ha Thanh Tan
 * -----
 * Last Modified: Friday, 15th October 2021 10:15:00 am
 * Modified By: Hieu Tran
 */

part of 'one_datetime_textfield.dart';

@freezed
class OneDateTimeValue with _$OneDateTimeValue {
  factory OneDateTimeValue({
    final DateTime? dateTime,
    final String? errorText,
    @Default(true) final bool isEnable,
  }) = _OneDateTimeValue;

  const OneDateTimeValue._();
}
