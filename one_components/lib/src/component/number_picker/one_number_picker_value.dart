/*
 * File: one_number_picker_value.dart
 * File Path: c:\PTPM1_IT_OneApp\one_components\lib\src\component\number_picker\one_number_picker_value.dart
 * File Created: Wednesday, 31/03/2021 11:56:37
 * Author: Lê Nguyên Trà (traln@Aneed.vn)
 * -----
 * Last Modified: Friday, 02/04/2021 08:42:02
 * Modified By: Hieu Tran
 * -----
 * Copyright OneBSS - 2021 , Trung tâm Aneed - IT3
 */

part of 'one_number_picker.dart';

class OneNumberPickerValue extends Equatable {
  const OneNumberPickerValue({
    this.number = 1,
    this.enable = true,
    this.visibility = OneVisibility.VISIBLE,
  });

  final double number;
  final bool enable;
  final OneVisibility visibility;

  /// A value that corresponds to the empty string with no selection and no composing range.
  static const OneNumberPickerValue empty = OneNumberPickerValue();

  /// Creates a copy of this value but with the given fields replaced with the new values.
  OneNumberPickerValue copyWith({
    double? number,
    bool? enable,
    OneVisibility? visibility,
  }) {
    return OneNumberPickerValue(
      number: number ?? this.number,
      enable: enable ?? this.enable,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  String toString() => 'OneNumberPickerValue {number: $number}';

  @override
  List<Object> get props => [
        number,
        enable,
        visibility,
      ];
}
