import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

const _tableName = "minesweeper_theme";

abstract class MinesweeperThemeRepository {
  Future<MinesweeperTheme?> fetchTheme();
}

class MinesweeperThemeSqliteRepository extends MinesweeperThemeRepository {
  Future<MinesweeperTheme?> fetchTheme() async {
    var accessor = await SqliteAccessor.accessor;
    var results = await accessor.fetch(_tableName);
    if(results[0] == null) return null;
    var entity = MinesweeperTheme.fromMap(results[0]!);
    return entity;
  }
}