import 'package:sqflite/sqflite.dart';
import 'package:minesweeper_flutter/constants/db_raw_statements.dart';

const String kpSqliteDbPath = "sksminesweeperdb.db";

/// An abstract implementation for a class that accesses
/// some sort of data storage.
abstract class Accessor {

  /// Initializes the accessor. For example, in a sqlite db,
  /// it opens the db file if it is closed.
  _initialize();

  /// Deletes all data, including both tables (keys) and values.
  /// This is used mainly for debugging purposes.
  void deleteAllData();

  /// Prints the database with all its contents to the console.
  /// This is used mainly for debugging purposes.
  void printData();

  /// Fetches all data with the given key
  void fetch(String key);

  /// Updates values for a given key.
  /// [rowId] is typically omitted in non-sql accessors.
  Future<int> update(String key, Map<String, dynamic> updatedColumnValues, int rowId);

  /// Updates a settings value. This is different from the [update] method
  /// in that it does not require a [rowId] param to operate, since there is a 
  /// single value for each setting.
  Future<int> updateSettings(String key, Map<String, dynamic> updatedColumnValues);

  bool get _shouldInitialize;
}


/// This class is responsible for accessing the app's Sqlite database
/// It exposes methods that repositories can use to manipulate the database.
class SqliteAccessor extends Accessor{
  // Singleton implementation ----------------------------------

  static SqliteAccessor _accessor = SqliteAccessor._internal();

  static Future<SqliteAccessor> get accessor async {
    if (_accessor._shouldInitialize) {
      await _accessor._initialize();
    }

    return _accessor;
  }

  // DbAccessor implementation ----------------------------------

  SqliteAccessor._internal();

  Database? _db;

  @override
  bool get _shouldInitialize => this._db == null || ! this._db!.isOpen;

  @override
  _initialize() async {
    _db = await openDatabase(
      kpSqliteDbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.transaction((txn) async {
          await txn.execute(ksGameSettingsTableCreateStatement);
          await txn.execute(ksLevelSettingsTableCreateStatement);
          await txn.execute(ksMinesweeperThemeTableCreateStatement);
          
          await txn.execute(ksMinesweeperThemeInitialDataInsertStatement);
          await txn.execute(ksGameSettingsInitialDataInsertStatement);
          await txn.execute(ksLevelSettingsInitialDataInsertStatement);
        });
      },
      onUpgrade: (db, oldVersion, newVersion) => {
        db.execute(""),
      },
    );
  }

  @override
  void deleteAllData() async {
    try {
      await deleteDatabase("${(await getDatabasesPath())}/$kpSqliteDbPath");
      print('deleted');
    } catch (err) {
      print(err);
    }
  }

  @override
  void printData() async {
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
