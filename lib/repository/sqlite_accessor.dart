import 'package:sqflite/sqflite.dart';

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
      onCreate: (db, version) {
        db.execute(_createStatement);
      },
    );
  }

  update(String table, Map<String, String> values) {
    _db!.query(table);
  }

  Future<List<Map<String, dynamic>>> fetch(String table) async {
    return await _db!.query(table);
  }

  insert(String query) {
    _db!.rawInsert(query);
  }

  String get _createStatement => '''
  CREATE TABLE "minesweeper_theme" (
	"background_color"	TEXT,
  "foreground_color" TEXT,
	"mine_icon"	TEXT,
	"flag_icon"	TEXT,
  "animation" TEXT,
	"tile_shape"	TEXT);

  INSERT INTO minesweeper_theme VALUES (
    "0xFFFFFFFF", "0xFF000000", "standard", "standard", "animation", "circle"
  )
  ''';
}
