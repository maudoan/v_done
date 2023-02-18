import 'package:json_annotation/json_annotation.dart';
import 'package:v_done/src/data/_base/json_utils.dart';

@JsonSerializable()
class CatalogDefault {
  @JsonKey(name: 'name', fromJson: $fromJsonToNullableString)
  String? name;
  @JsonKey(name: 'id', fromJson: $fromJsonToNullableString)
  String? id;
  @JsonKey(name: 'id_danhmuc', fromJson: $fromJsonToNullableInt)
  int? id_danhmuc;

  CatalogDefault({this.name, this.id, this.id_danhmuc});

  // factory CatalogDefault.fromJson(Map<String, dynamic> json) => _$CatalogDefaultFromJson(json);
  // Map<String, dynamic> toJson() => _$CatalogDefaultToJson(this);
}
