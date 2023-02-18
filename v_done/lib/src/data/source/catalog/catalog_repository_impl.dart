// /*
//  * File: tienich_catalog_repository_impl.dart
//  * File Created: Monday, 30th August 2021 11:11:54 am
//  * Author: Hieu Tran
//  * -----
//  * Last Modified: Monday, 30th August 2021 11:20:37 am
//  * Modified By: Hieu Tran
//  */

// import 'dart:developer';

// import 'package:v_done/src/data/_core/error.dart';

// import '../../model/catalog/catalog_param.dart';
// import 'catalog.dart';
// import 'catalog_repository.dart';

// class CatalogStorageRepository implements CatalogRepository {
//   final CatalogRepository localStorage;
//   final CatalogRepository webApi;

//   const CatalogStorageRepository({
//     required this.localStorage,
//     required this.webApi,
//   });

//   // @override
//   // Future<List<Catalog>> danhMuc({
//   //   required CatalogParam param,
//   //   String? searchText,
//   //   bool forceUpdate = false,
//   // }) async {
//   //   Future<List<Catalog>> fetchAndSaveRemote() {
//   //     return webApi.danhMuc(param: param).then(
//   //       (listCatalog) {
//   //         localStorage.deleteList(param.listIdDanhMuc);
//   //         localStorage.save(listCatalog);
//   //         return localStorage.danhMuc(param: param, searchText: searchText);
//   //       },
//   //     ).catchError(ErrorHandling().onError);
//   //   }

//   //   if (forceUpdate) {
//   //     return fetchAndSaveRemote();
//   //   } else {
//   //     try {
//   //       final listCatalog =
//   //           await localStorage.danhMuc(param: param, searchText: searchText);
//   //       if ((searchText == null || searchText.isEmpty) && listCatalog.isEmpty) {
//   //         return fetchAndSaveRemote();
//   //       }
//   //       return listCatalog;
//   //     } catch (e) {
//   //       log(e.toString());
//   //       return fetchAndSaveRemote();
//   //     }
//   //   }
//   // }

//   @override
//   Future save(List<Catalog> listCatalog) {
//     return localStorage.save(listCatalog);
//   }

//   @override
//   Future delete(int catalogType) {
//     return localStorage.delete(catalogType);
//   }

//   @override
//   Future deleteList(List<int?> listIdDanhMuc) {
//     return localStorage.deleteList(listIdDanhMuc);
//   }
// }
