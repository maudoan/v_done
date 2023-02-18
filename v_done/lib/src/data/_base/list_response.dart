/*
 * File: list_response.dart
 * File Created: Friday, 15th January 2021 2:00:17 pm
 * Author: Hieu Tran
 * -----
 * Last Modified: Friday, 15th January 2021 2:02:09 pm
 * Modified By: Hieu Tran
 */

import 'package:json_annotation/json_annotation.dart';

part 'list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ListResponse<T> {
  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'maxSize')
  int? maxSize;

  @JsonKey(name: 'totalElement')
  int? totalElement;

  @JsonKey(name: 'sort')
  String? sort;

  @JsonKey(name: 'propertiesSort')
  String? propertiesSort;

  @JsonKey(name: 'data')
  List<T>? data;

  ListResponse({
    this.page,
    this.maxSize,
    this.totalElement,
    this.sort,
    this.propertiesSort,
    this.data,
  });

  factory ListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$ListResponseFromJson(json, fromJsonT);
}
