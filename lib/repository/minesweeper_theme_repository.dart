import 'package:minesweeper_flutter/entities/minesweeper_theme_entity.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

const _tableName = "minesweeper_theme";

abstract class MinesweeperThemeRepository {
  Future<MinesweeperThemeEntity> fetchTheme();
}

class MinesweeperSqliteThemeRepository extends MinesweeperThemeRepository {
  Future<MinesweeperThemeEntity> fetchTheme() async {
    var accessor = await SqliteAccessor.accessor;
    var results = await accessor.fetch(_tableName);
    var entity = MinesweeperThemeEntity.fromMap(results[0]);
    return entity;
  }
}