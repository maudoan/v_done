/*
 * File: one_radio_value.dart
 * File Created: Monday, 1st March 2021 8:15:28 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 1st March 2021 9:38:26 pm
 * Modified By: Hieu Tran
 */

part of 'one_radio.dart';

class OneRadioValue<T> extends Equatable {
  const OneRadioValue({
    this.enable = true,
    required this.groupListenable,
    this.label,
    this.visibility = OneVisibility.VISIBLE,
  });

  final ValueNotifier<T> groupListenable;
  final bool enable;
  final String? label;
  final OneVisibility visibility;

  /// A value that corresponds to the empty string with no selection and no composing range.
  static OneRadioValue empty = OneRadioValue(groupListenable: ValueNotifier(null));

  /// Creates a copy of this value but with the given fields replaced with the new values.
  OneRadioValue copyWith({
    ValueNotifier<T>? groupListenable,
    bool? enable,
    bool? selected,
    String? label,
    OneVisibility? visibility,
  }) {
    return OneRadioValue(
      groupListenable: groupListenable ?? this.groupListenable,
      enable: enable ?? this.enable,
      label: label ?? this.label,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  String toString() => 'OneRadioValue {label: $label, groupListenable: $groupListenable, enable: $enable}';

  @override
  List<Object?> get props => [
        groupListenable,
        enable,
        label,
        visibility,
      ];
}
