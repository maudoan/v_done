// /*
//  * File: catalog_sqlite_storage.dart
//  * File Created: Friday, 15th January 2021 3:25:28 pm
//  * Author: Hieu Tran
//  * -----
//  * Last Modified: Monday, 18th January 2021 5:23:05 pm
//  * Modified By: Hieu Tran
//  */

// import 'package:diacritic/diacritic.dart';
// import 'package:one_base/one_base.dart';
// import 'package:v_done/src/data/source/catalog/catalog_repository.dart';

// import '../../source/catalog/catalog.dart';
// import '../../source/catalog/catalog_tree_utils.dart';
// import 'sqlite_persistence.dart';

// class CatalogSqliteStorage implements CatalogRepository {
//   final SqlitePersistence persistence;

//   CatalogSqliteStorage({
//     required this.persistence,
//   });

//   // @override
//   // Future<List<Catalog>> danhMuc(
//   //     {required CatalogParam param,
//   //     String? searchText,
//   //     bool forceUpdate = false}) async {
//   //   final List<Catalog> maps = [];
//   //   final search = searchText == null || searchText.isEmpty
//   //       ? searchText
//   //       : removeDiacritics(searchText).toLowerCase();
//   //   for (final id in param.listIdDanhMuc) {
//   //     final items = await persistence.catalog(id,
//   //         param: param.param,
//   //         nguonDuLieu: param.nguonDuLieu,
//   //         searchText: search);
//   //     final listCatalog = items.map((item) => Catalog.fromJson(item)).toList();
//   //     maps.addAll($loadCatalogTree(listCatalog));
//   //   }

//   //   return maps;
//   // }

//   @override
//   Future save(List<Catalog> listCatalog) async {
//     await persistence.insertOrUpdateCatalog(listCatalog);
//   }

//   @override
//   Future delete(int catalogType,
//       {String? parentId, String? param, String? nguonDuLieu}) async {
//     await persistence.deleteCatalog(catalogType,
//         parentId: parentId, param: param, nguonDuLieu: nguonDuLieu);
//   }

//   @override
//   Future deleteList(List<int?> listIdDanhMuc,
//       {String? param, String? nguonDuLieu}) async {
//     await persistence.deleteCatalogList(listIdDanhMuc,
//         param: param, nguonDuLieu: nguonDuLieu);
//   }

//   @override
//   Future clear() async {
//     await persistence.clearCatalog();
//   }
// }
