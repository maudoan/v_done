// /*
//  * File: catalog_sqlite_persistence.dart
//  * File Created: Sunday, 7th March 2021 6:50:33 pm
//  * Author: Hieu Tran
//  * -----
//  * Last Modified: Sunday, 7th March 2021 6:52:09 pm
//  * Modified By: Hieu Tran
//  */

// part of 'sqlite_persistence.dart';

// extension CatalogSqlitePersistence on SqlitePersistence {
//   Future<List<Map<String, dynamic>>> catalog(int? type,
//       {String? parentId,
//       String? param,
//       String? searchText,
//       String? nguonDuLieu}) async {
//     final db = await database;
//     const _searchPattern = '***SEARCH_QUERY_RIGHT_HERE***';
//     String sql = '''
//         WITH RECURSIVE PATHS AS (
//             SELECT Y.*, Y.ROWID FROM ${SqlitePersistence._catalogTableName} Y
//             WHERE CATEGORY_TYPE = ? $_searchPattern
//             UNION
//             SELECT X.*, X.ROWID
//             FROM ${SqlitePersistence._catalogTableName} X JOIN PATHS
//             WHERE X.ID = PATHS.PARENT_ID
//         )
//         SELECT A.*, IFNULL(B.NUM_CHILDS, 0) AS NUM_CHILDS
//         FROM PATHS A
//         LEFT JOIN
//           (SELECT PARENT_ID, COUNT(PARENT_ID) AS NUM_CHILDS
//             FROM ${SqlitePersistence._catalogTableName}
//             WHERE CATEGORY_TYPE = ?
//             GROUP BY PARENT_ID) B
//         ON A.ID = B.PARENT_ID
//         WHERE CATEGORY_TYPE = ?
//     ''';
//     // String sql = '''
//     //     SELECT A.*,
//     //       IFNULL(B.NUM_CHILDS, 0) AS NUM_CHILDS,
//     //       A.SEARCH_TEXT || ',' || B.SUM_SEARCH_TEXT AS SUM_SEARCH_TEXT
//     //     FROM ${OneSqlitePersistence._catalogTableName} A
//     //     LEFT JOIN
//     //         (SELECT PARENT_ID, COUNT(PARENT_ID) AS NUM_CHILDS, GROUP_CONCAT(SEARCH_TEXT) SUM_SEARCH_TEXT
//     //         FROM ${OneSqlitePersistence._catalogTableName}
//     //         WHERE CATEGORY_TYPE = ?
//     //         GROUP BY PARENT_ID
//     //         ) B
//     //     ON A.ID = B.PARENT_ID
//     //     WHERE CATEGORY_TYPE = ?
//     // ''';

//     final List<dynamic> arguments = [type, type, type];
//     if (parentId != null && parentId.isNotEmpty) {
//       sql = '$sql AND PARENT_ID = ?';
//       arguments.add(parentId);
//     }

//     if (param != null && param.isNotEmpty) {
//       sql = '$sql AND PARAM = ?';
//       arguments.add(param);
//     }

//     if (nguonDuLieu != null && nguonDuLieu.isNotEmpty) {
//       sql = '$sql AND NGUON_DULIEU = ?';
//       arguments.add(nguonDuLieu);
//     }

//     if (searchText != null && searchText.isNotEmpty) {
//       sql = sql.replaceFirst(_searchPattern, ' AND SEARCH_TEXT LIKE ?');
//       arguments.insert(1, '%$searchText%');
//     } else {
//       sql = sql.replaceFirst(_searchPattern, ' ');
//     }

//     sql = '$sql ORDER BY A.ROWID';

//     final ret = await db!.rawQuery(sql, arguments);
//     return ret;
//   }

//   Future<void> insertOrUpdateCatalog(List<Catalog> catalogList) async {
//     final db = await database;
//     final Batch batch = db!.batch();
//     for (final catalog in catalogList) {
//       batch.insert(
//         SqlitePersistence._catalogTableName,
//         catalog.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }
//     await batch.commit(noResult: true);
//   }

//   Future<void> deleteCatalog(int catalogType,
//       {String? parentId, String? param, String? nguonDuLieu}) async {
//     final db = await database;
//     final Batch batch = db!.batch();
//     String sql = 'CATEGORY_TYPE = ?';
//     final List<dynamic> arguments = [catalogType];
//     if (parentId != null && parentId.isNotEmpty) {
//       sql = '$sql AND PARENT_ID = ?';
//       arguments.add(parentId);
//     }

//     if (param != null && param.isNotEmpty) {
//       sql = '$sql AND PARAM = ?';
//       arguments.add(param);
//     }

//     if (nguonDuLieu != null && nguonDuLieu.isNotEmpty) {
//       sql = '$sql AND NGUON_DULIEU = ?';
//       arguments.add(nguonDuLieu);
//     }

//     batch.delete(
//       SqlitePersistence._catalogTableName,
//       where: sql,
//       whereArgs: arguments,
//     );
//     await batch.commit(noResult: true);
//   }

//   Future<void> deleteCatalogList(List<int?> listIdDanhMuc,
//       {String? param, String? nguonDuLieu}) async {
//     final db = await database;
//     final Batch batch = db!.batch();
//     for (final type in listIdDanhMuc) {
//       String sql = 'CATEGORY_TYPE = ?';
//       final List<dynamic> arguments = [type];

//       if (param != null && param.isNotEmpty) {
//         sql = '$sql AND PARAM = ?';
//         arguments.add(param);
//       }

//       if (nguonDuLieu != null && nguonDuLieu.isNotEmpty) {
//         sql = '$sql AND NGUON_DULIEU = ?';
//         arguments.add(nguonDuLieu);
//       }

//       batch.delete(
//         SqlitePersistence._catalogTableName,
//         where: sql,
//         whereArgs: arguments,
//       );
//     }

//     await batch.commit(noResult: true);
//   }

//   Future<void> clearCatalog() async {
//     final db = await database;
//     final Batch batch = db!.batch();
//     batch.delete(SqlitePersistence._catalogTableName);

//     await batch.commit(noResult: true);
//   }
// }
