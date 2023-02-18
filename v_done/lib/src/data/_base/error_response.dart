import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable(createToJson: false)
class ErrorResponse {
  final String? timestamp;
  final int? status;
  final String? error;
  final String? message;
  final String? path;

  ErrorResponse({
    this.timestamp,
    this.status,
    this.path,
    this.message,
    this.error,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
}
