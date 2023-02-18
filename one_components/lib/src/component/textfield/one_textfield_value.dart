/*
 * File: one_textfield_value.dart
 * File Created: Tuesday, 9th March 2021 9:46:41 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Tuesday, 9th March 2021 9:54:39 pm
 * Modified By: Hieu Tran
 */

part of 'one_textfield.dart';

class OneTextFieldValue extends Equatable {
  const OneTextFieldValue({
    this.text = '',
    this.enable = true,
    this.visibility = OneVisibility.VISIBLE,
    this.errorText,
    this.isRequired = false,
    this.prefixIconAssetPath,
  });

  final String text;
  final bool enable;
  final OneVisibility visibility;
  final String? errorText;
  final bool isRequired;
  final String? prefixIconAssetPath;

  /// A value that corresponds to the empty string with no selection and no composing range.
  static const OneTextFieldValue empty = OneTextFieldValue();

  /// Creates a copy of this value but with the given fields replaced with the new values.
  OneTextFieldValue copyWith({
    String? text,
    bool? enable,
    OneVisibility? visibility,
    String? errorText,
    bool? isRequired,
  }) {
    return OneTextFieldValue(
      text: text?.trim() ?? this.text,
      enable: enable ?? this.enable,
      visibility: visibility ?? this.visibility,
      errorText: errorText?.trim(),
      isRequired: isRequired ?? this.isRequired,
    );
  }

  @override
  String toString() => 'OneTextFieldValue {text: $text}';

  @override
  List<Object?> get props => [
        text,
        enable,
        visibility,
        errorText,
        isRequired,
        prefixIconAssetPath,
      ];
}
