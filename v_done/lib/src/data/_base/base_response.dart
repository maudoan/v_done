import 'package:json_annotation/json_annotation.dart';

import 'page_info.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BaseResponse<T> {
  @JsonKey(name: 'timestamp')
  final dynamic timestamp;

  @JsonKey(name: 'status')
  final dynamic status;

  @JsonKey(name: 'error')
  final dynamic error;

  @JsonKey(name: 'error_code')
  final String? errorCode;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'data')
  final T? data;

  @JsonKey(name: 'request_id')
  final String? requestId;

  @JsonKey(name: 'path')
  final String? path;

  @JsonKey(name: 'page_info')
  final PageInfo? pageInfo;

  BaseResponse({
    this.timestamp,
    this.status,
    this.error,
    this.errorCode,
    this.message,
    this.data,
    this.requestId,
    this.path,
    this.pageInfo,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  String getMessage() {
    String msg = '';
    final _errorCode = errorCode?.trim();
    if (_errorCode?.isNotEmpty ?? false) {
      msg = '[$_errorCode]';
    }
    final _message = message?.trim();
    if (_message?.isNotEmpty ?? false) {
      msg = msg.isNotEmpty ? '$msg $_message' : _message!;
    }

    if (msg.isEmpty) {
      final _error = error?.trim();
      final _path = path?.trim();
      if (status != null) msg = '$status';
      if (_error?.isNotEmpty ?? false)
        msg = msg.isNotEmpty ? '$msg $_error' : _error!;
      if (_path?.isNotEmpty ?? false)
        msg = msg.isNotEmpty ? '$msg\n$_path' : _path!;
    }

    final _reqId = requestId == null
        ? ''
        : requestId!.substring(requestId!.lastIndexOf('-') + 1);
    msg = requestId == null ? msg.trim() : '$msg\n$_reqId';

    return msg.trim();
  }
}
