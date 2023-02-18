/*
 * File: json_utils.dart
 * File Created: Sunday, 25th July 2021 11:07:31 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Sunday, 25th July 2021 11:10:23 pm
 * Modified By: Hieu Tran
 */

String? $fromJsonToNullableString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

String $fromJsonToString(dynamic value) {
  if (value == null) return '';
  return value.toString();
}

int? $fromJsonToNullableInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  return int.tryParse(value.toString());
}

int $fromJsonToInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}

double? $fromJsonToNullableDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}

double $fromJsonToDouble(dynamic value) {
  if (value == null) return 0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0;
}
