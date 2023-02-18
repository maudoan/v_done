/*
 * File: one_button_value.dart
 * File Created: Friday, 26th February 2021 1:02:52 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 26th February 2021 1:03:09 am
 * Modified By: Hieu Tran
 */

part of 'one_button.dart';

class OneButtonValue extends Equatable {
  const OneButtonValue({
    this.enable = true,
    this.state = OneButtonState.primary,
    this.label,
    this.visibility = OneVisibility.VISIBLE,
  });

  final bool enable;
  final OneButtonState state;
  final String? label;
  final OneVisibility visibility;

  /// A value that corresponds to the empty string with no selection and no composing range.
  static const OneButtonValue empty = OneButtonValue();

  /// Creates a copy of this value but with the given fields replaced with the new values.
  OneButtonValue copyWith({
    bool? enable,
    OneButtonState? state,
    String? label,
    OneVisibility? visibility,
  }) {
    return OneButtonValue(
      enable: enable ?? this.enable,
      state: state ?? this.state,
      label: label ?? this.label,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  String toString() => 'OneButtonValue {label: $label, state: $state, enable: $enable}';

  @override
  List<Object?> get props => [
        enable,
        state,
        label,
        visibility,
      ];
}
