/*
 * File: one_search_value.dart
 * File Created: Monday, 15th March 2021 2:17:11 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 15th March 2021 2:20:17 pm
 * Modified By: Hieu Tran
 */

part of 'one_search_field.dart';

class OneSearchValue extends Equatable {
  const OneSearchValue({
    this.text = '',
    this.enable = true,
    this.visibility = OneVisibility.VISIBLE,
  });

  final String text;
  final bool enable;
  final OneVisibility visibility;

  /// A value that corresponds to the empty string with no selection and no composing range.
  static const OneSearchValue empty = OneSearchValue();

  /// Creates a copy of this value but with the given fields replaced with the new values.
  OneSearchValue copyWith({
    String? text,
    bool? enable,
    OneVisibility? visibility,
  }) {
    return OneSearchValue(
      text: text ?? this.text,
      enable: enable ?? this.enable,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  String toString() => 'OneSearchValue {text: $text}';

  @override
  List<Object> get props => [
        text,
        enable,
        visibility,
      ];
}
