/*
 * File: one_checkbox_value.dart
 * File Created: Friday, 26th February 2021 1:51:29 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 26th February 2021 1:53:01 pm
 * Modified By: Hieu Tran
 */

part of 'one_checkbox.dart';

class OneCheckboxValue extends Equatable {
  const OneCheckboxValue({
    this.enable = true,
    this.selected = false,
    this.label,
    this.visibility = OneVisibility.VISIBLE,
  });

  final bool enable;
  final bool selected;
  final String? label;
  final OneVisibility visibility;

  /// A value that corresponds to the empty string with no selection and no composing range.
  static const OneCheckboxValue empty = OneCheckboxValue();

  /// Creates a copy of this value but with the given fields replaced with the new values.
  OneCheckboxValue copyWith({
    bool? enable,
    bool? selected,
    String? label,
    OneVisibility? visibility,
  }) {
    return OneCheckboxValue(
      enable: enable ?? this.enable,
      selected: selected ?? this.selected,
      label: label ?? this.label,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  String toString() => 'OneCheckboxValue {label: $label, selected: $selected, enable: $enable}';

  @override
  List<Object?> get props => [
        enable,
        selected,
        label,
        visibility,
      ];
}
