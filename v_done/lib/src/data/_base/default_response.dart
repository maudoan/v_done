/*
 * File: default_response.dart
 * File Created: Monday, 18th January 2021 12:39:59 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 18th January 2021 12:40:13 am
 * Modified By: Hieu Tran
 */

import 'package:json_annotation/json_annotation.dart';

part 'default_response.g.dart';

@JsonSerializable(createToJson: false)
class DefaultResponse {
  final String? data;
  final String? error_code;
  final String? message;
  final String? result;
  final String? res_mes;
  final String? err_msg;
  final String? err_message;
  final String? ket_qua;
  final int? err_code;
  final int? res_code;
  final int? trangthai;

  DefaultResponse({
    this.data,
    this.error_code,
    this.message,
    this.result,
    this.res_mes,
    this.err_msg,
    this.err_message,
    this.ket_qua,
    this.err_code,
    this.res_code,
    this.trangthai,
  });

  factory DefaultResponse.fromJson(Map<String, dynamic> json) => _$DefaultResponseFromJson(json);
}
