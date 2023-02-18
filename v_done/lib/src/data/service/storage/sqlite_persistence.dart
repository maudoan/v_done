// /*
//  * File: one_sqlite_persistence.dart
//  * File Created: Monday, 18th January 2021 5:10:49 pm
//  * Author: Hieu Tran
//  * -----
//  * Last Modified: Monday, 18th January 2021 5:13:50 pm
//  * Modified By: Hieu Tran
//  */

// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// import '../../source/catalog/catalog.dart';

// part 'catalog_sqlite_persistence.dart';

// class SqlitePersistence {
//   static const _databaseName = 'VDone.db';
//   static const _databaseVersion = 1;
//   static const _catalogTableName = 'catalog';

//   SqlitePersistence._privateConstructor();
//   static final SqlitePersistence instance =
//       SqlitePersistence._privateConstructor();

//   Database? _database;
//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     }
//     _database = await _initDatabase();
//     return _database;
//   }

//   Future _initDatabase() async {
//     final path = await getDatabasesPath();
//     final dbPath = join(path, _databaseName);
//     return await openDatabase(
//       dbPath,
//       version: _databaseVersion,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     final Batch batch = db.batch();
//     batch.execute('''
//             CREATE TABLE IF NOT EXISTS $_catalogTableName (
//             CATEGORY_TYPE INTEGER NOT NULL,
//             ID TEXT NOT NULL,
//             NAME TEXT,
//             DESCRIPTION TEXT,
//             LEVEL INTEGER,
//             PARENT_ID TEXT,
//             PARENT_NAME TEXT,
//             EXT_INFO TEXT,
//             EXPANDED INTEGER,
//             PARAM TEXT,
//             NGUON_DULIEU TEXT,
//             SEARCH_TEXT TEXT,
//             PRIMARY KEY (CATEGORY_TYPE, ID, LEVEL, PARAM)
//           )
//           ''');

//     await batch.commit(noResult: true);
//   }

//   Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     if (oldVersion < newVersion) {
//       final Batch batch = db.batch();
//       batch.execute('DROP TABLE IF EXISTS $_catalogTableName');
//       await batch.commit(noResult: true);
//       await _onCreate(db, newVersion);
//     }
//   }
// }
