import 'package:minesweeper_flutter/constants/db_keys.dart';
import 'package:minesweeper_flutter/entities/minesweeper_theme_entity.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

abstract class MinesweeperThemeRepository {
  Future<MinesweeperThemeEntity> fetchTheme();

  Future<bool> update(MinesweeperThemeEntity theme);
}

class MinesweeperThemeSqliteRepository extends MinesweeperThemeRepository {
  @override
  Future<MinesweeperThemeEntity> fetchTheme() async {
    var accessor = await SqliteAccessor.accessor;
    var results = await accessor.fetch(kkMinesweeperThemeTableKey);
    var entity = MinesweeperThemeEntity.fromMap(results[0]!);
    return entity;
  }

  @override
  Future<bool> update(MinesweeperThemeEntity entity) async {
    var accessor = await SqliteAccessor.accessor;
    int updatedRows = await accessor.updateSettings(
        kkMinesweeperThemeTableKey, entity.toMap());
    return updatedRows > 0;
  }
}
