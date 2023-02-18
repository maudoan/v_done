/*
 * File: one_switch_value.dart
 * File Created: Friday, 7th May 2021 9:29:15 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 7th May 2021 9:30:54 am
 * Modified By: Hieu Tran
 */

part of 'one_switch.dart';

class OneSwitchValue extends Equatable {
  const OneSwitchValue({
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
  static const OneSwitchValue empty = OneSwitchValue();

  /// Creates a copy of this value but with the given fields replaced with the new values.
  OneSwitchValue copyWith({
    bool? enable,
    bool? selected,
    String? label,
    OneVisibility? visibility,
  }) {
    return OneSwitchValue(
      enable: enable ?? this.enable,
      selected: selected ?? this.selected,
      label: label ?? this.label,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  String toString() => 'OneSwitchValue {label: $label, selected: $selected, enable: $enable}';

  @override
  List<Object?> get props => [
        enable,
        selected,
        label,
        visibility,
      ];
}
