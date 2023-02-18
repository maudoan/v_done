// /*
//  * File: catalog.dart
//  * File Created: Friday, 15th January 2021 11:49:32 am
//  * Author: Hieu Tran
//  * -----
//  * Last Modified: Friday, 15th January 2021 11:53:18 am
//  * Modified By: Hieu Tran
//  */

// import 'package:diacritic/diacritic.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// import '../../../shared/constant.dart';
// import '../../_base/json_utils.dart';

// part 'catalog.g.dart';

// @JsonSerializable()
// class Catalog with EquatableMixin implements CatalogSearchUtils {
//   @JsonKey(name: 'CATEGORY_TYPE', fromJson: $fromJsonToNullableInt)
//   final int? type;
//   @JsonKey(name: 'ID', fromJson: $fromJsonToString)
//   final String? id;
//   @JsonKey(name: 'NAME', fromJson: $fromJsonToNullableString)
//   final String? name;
//   @JsonKey(name: 'DESCRIPTION', fromJson: $fromJsonToNullableString)
//   final String? description;
//   @JsonKey(name: 'LEVEL', defaultValue: 0, fromJson: $fromJsonToInt)
//   final int level;
//   @JsonKey(name: 'PARENT_ID', fromJson: $fromJsonToNullableString)
//   final String? parentId;
//   @JsonKey(name: 'PARENT_NAME', fromJson: $fromJsonToNullableString)
//   final String? parentName;
//   @JsonKey(name: 'EXT_INFO', fromJson: $fromJsonToNullableString)
//   final String? extInfo;
//   @JsonKey(name: 'EXPANDED', fromJson: $fromJsonToNullableInt)
//   final int? expanded;

//   @JsonKey(name: 'PARAM', fromJson: $fromJsonToNullableString)
//   final String? param;
//   @JsonKey(name: 'NGUON_DULIEU', fromJson: $fromJsonToNullableString)
//   final String? nguonDuLieu;
//   @JsonKey(name: 'NUM_CHILDS', toJson: toNull, includeIfNull: false)
//   final int? numChilds;
//   @JsonKey(name: 'SEARCH_TEXT')
//   final String? searchText;
//   @JsonKey(ignore: true)
//   List<Catalog>? children;
//   @JsonKey(ignore: true)
//   bool isRemoved = false;
//   @JsonKey(ignore: true)
//   int? selected;

//   String genSearchQuery() {
//     // final search = '$name';
//     return removeDiacritics('$name$description').toLowerCase();
//   }

//   Catalog({
//     this.type,
//     this.id,
//     this.name,
//     this.description,
//     this.level = 0,
//     this.parentId,
//     this.parentName,
//     this.extInfo,
//     this.expanded,
//     this.param,
//     this.nguonDuLieu,
//     this.children,
//     this.numChilds,
//     this.searchText,
//     this.selected,
//   });

//   factory Catalog.fromJson(Map<String, dynamic> json) =>
//       _$CatalogFromJson(json);

//   Map<String, dynamic> toJson() => _$CatalogToJson(this);

//   Catalog copyWith({
//     int? type,
//     String? id,
//     String? name,
//     String? description,
//     int? level,
//     String? parentId,
//     String? parentName,
//     String? extInfo,
//     int? expanded,
//     String? param,
//     String? nguonDuLieu,
//     List<Catalog>? children,
//     int? numChilds,
//     String? searchText,
//     int? selected,
//   }) {
//     return Catalog(
//       type: type ?? this.type,
//       id: id ?? this.id,
//       name: name ?? this.name,
//       description: description ?? this.description,
//       level: level ?? this.level,
//       parentId: parentId ?? this.parentId,
//       parentName: parentName ?? this.parentName,
//       extInfo: extInfo ?? this.extInfo,
//       expanded: expanded ?? this.expanded,
//       param: param ?? this.param,
//       nguonDuLieu: nguonDuLieu ?? this.nguonDuLieu,
//       children: children ?? this.children,
//       numChilds: numChilds ?? this.numChilds,
//       searchText: searchText ?? this.searchText,
//       selected: selected ?? this.selected,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         // type,
//         id,
//         // name,
//         // level,
//         // parentId,
//         // parentName,
//         // extInfo,
//         // expanded,
//         // param,
//         // nguonDuLieu,
//         // children,
//         // numChilds,
//         // searchText,
//       ];

//   @override
//   String toString() => '$name';

//   @override
//   bool filterWith(String query) {
//     return genSearchQuery().contains(removeDiacritics(query).toLowerCase());
//   }

//   int? get tryIntId => hasValue ? int.tryParse(id!) : null;
//   bool get hasValue => id?.isNotEmpty ?? false;
// }
