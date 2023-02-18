/*
 * File: one_page_value.dart
 * File Created: Wednesday, 28th July 2021 11:42:03 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Wednesday, 28th July 2021 11:48:31 am
 * Modified By: Hieu Tran
 */

part of 'one_page_number.dart';

class OnePageValue extends Equatable {
  const OnePageValue({
    this.enable = true,
    this.currentPage = 1,
    this.maxSize,
    this.visibility = OneVisibility.VISIBLE,
  });

  final bool enable;
  final int currentPage;
  final int? maxSize;
  final OneVisibility visibility;

  /// A value that corresponds to the empty string with no selection and no composing range.
  static const OnePageValue empty = OnePageValue();

  /// Creates a copy of this value but with the given fields replaced with the new values.
  OnePageValue copyWith({
    bool? enable,
    int? currentPage,
    int? maxSize,
    OneVisibility? visibility,
  }) {
    return OnePageValue(
      enable: enable ?? this.enable,
      currentPage: currentPage ?? this.currentPage,
      maxSize: maxSize,
      visibility: visibility ?? this.visibility,
    );
  }

  @override
  String toString() => 'OnePageValue {currentPage: $currentPage, maxSize: $maxSize, enable: $enable}';

  @override
  List<Object?> get props => [
        enable,
        currentPage,
        maxSize,
        visibility,
      ];
}
