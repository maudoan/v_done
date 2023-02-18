/*
 * File: one_error.dart
 * File Created: Monday, 11th January 2021 4:33:19 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Monday, 11th January 2021 5:09:31 pm
 * Modified By: Hieu Tran
 */

import 'dart:convert';

import 'package:dio/dio.dart';

import '../_base/base_response.dart';

part 'error_handling.dart';

class OneError implements Exception {
  BaseResponse? resBase;
  DioError? dioError;

  /// The original error/exception object
  dynamic error;

  OneError({this.resBase, this.dioError, this.error});

  String get message {
    String msg = '';
    if (resBase != null)
      msg = resBase!.getMessage();
    else if (dioError != null) {
      final _statusCode = dioError?.response?.statusCode ?? 0;
      if (dioError?.type == DioErrorType.response &&
          (_statusCode >= 500 && _statusCode < 600))
        msg = 'Hệ thống đang bận, Vui lòng thực hiện lại sau !';
      else
        msg = dioError?.message ?? dioError.toString();

      try {
        if (dioError?.response?.data is Map) {
          String? _reqId = dioError?.response?.data['request_id'];
          _reqId = _reqId == null
              ? ''
              : _reqId.substring(_reqId.lastIndexOf('-') + 1);
          msg = _reqId == '' ? msg : '$msg\n$_reqId';
        }
        // ignore: empty_catches
      } catch (e) {}
    } else if (error != null) msg = error.toString();

    return msg.trim().isEmpty ? 'Unexpected Error Exception' : msg.trim();
  }

  @override
  String toString() {
    if (error is Error) return '$message';
    return message;
  }
}
