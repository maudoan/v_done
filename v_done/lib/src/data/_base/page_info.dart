/*
 * File: page_info.dart
 * File Created: Thursday, 28th October 2021 8:27:19 am
 * Author: Hieu Tran
 * -----
 * Last Modified: Thursday, 28th October 2021 8:31:33 am
 * Modified By: Hieu Tran
 */

import 'package:json_annotation/json_annotation.dart';

import 'json_utils.dart';

part 'page_info.g.dart';

@JsonSerializable(createToJson: false)
class PageInfo {
  @JsonKey(name: 'page_num', fromJson: $fromJsonToInt)
  final int pageNum;
  @JsonKey(name: 'page_size', fromJson: $fromJsonToInt)
  final int pageSize;
  @JsonKey(name: 'record_count', fromJson: $fromJsonToInt)
  final int recordCount;
  @JsonKey(name: 'page_rec', fromJson: $fromJsonToInt)
  final int pageRec;

  PageInfo({
    this.pageNum = 0,
    this.pageSize = 0,
    this.recordCount = 0,
    this.pageRec = 0,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) => _$PageInfoFromJson(json);

  int get maxSize => pageRec > 0 ? (recordCount / pageRec).ceil() : 0;
}
