import 'package:sqflite/sqflite.dart';
import 'package:minesweeper_flutter/constants/db_raw_statements.dart';

const String kpSqliteDbPath = "sksminesweeperdb.db";

/// This class is responsible for accessing the app's Sqlite database
/// It exposes methods that repositories can use to manipulate the database.
class SqliteAccessor {
  // Singleton implementation ----------------------------------

  static SqliteAccessor _accessor = SqliteAccessor._internal();

  static Future<SqliteAccessor> get accessor async {
    if (_accessor._db == null || !_accessor._db!.isOpen) {
      await _accessor._initializeDb();
    }

    return _accessor;
  }

  // DbAccessor implementation ----------------------------------

  SqliteAccessor._internal();

  Database? _db;

  _initializeDb() async {
    _db = await openDatabase(
      kpSqliteDbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.transaction((txn) async {
          await txn.execute(ksGameSettingsTableCreateStatement);
          await txn.execute(ksMinesweeperLevelSettingsTableCreateStatement);
          await txn.execute(ksMinesweeperThemeTableCreateStatement);
          
          await txn.execute(ksMinesweeperThemeInitialDataInsertStatement);
          await txn.execute(ksGameSettingsInitialDataInsertStatement);
        });
      },
      onUpgrade: (db, oldVersion, newVersion) => {
        db.execute(""),
      },
    );
  }

  void deleteDb() async {
    try {
      await deleteDatabase("${(await getDatabasesPath())}/$kpSqliteDbPath");
      print('deleted');
    } catch (err) {
      print(err);
    }
  }

  void printDb() async {
    (await _db!.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });
  }

  Future<List<Map<String, dynamic>?>> fetch(String table) async {
    return await _db!.query(table);
  }

  Future<int> updateSettings(
      String table, Map<String, dynamic> updatedColumnValues) async {
    int updatedRows = await _db!.update(table, updatedColumnValues);
    return updatedRows;
  }

  Future<int> update(
      String table, Map<String, dynamic> updatedColumnValues, int rowId) async {
    int updatedRows = await _db!.update(table, updatedColumnValues,
        where: "WHERE id = ?s", whereArgs: [rowId]);
    return updatedRows;
  }
}
