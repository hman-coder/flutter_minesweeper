import 'package:minesweeper_flutter/constants/db_keys.dart';
import 'package:minesweeper_flutter/entities/game_theme_entity.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

abstract class GameThemeRepository {
  Future<GameThemeEntity> fetchTheme();

  Future<bool> update(GameThemeEntity theme);
}

class GameThemeSqliteRepository extends GameThemeRepository {
  @override
  Future<GameThemeEntity> fetchTheme() async {
    var accessor = await SqliteAccessor.accessor;
    var results = await accessor.fetch(kkMinesweeperThemeTableKey);
    var entity = GameThemeEntity.fromMap(results[0]!);
    return entity;
  }

  @override
  Future<bool> update(GameThemeEntity entity) async {
    var accessor = await SqliteAccessor.accessor;
    int updatedRows = await accessor.updateSettings(
        kkMinesweeperThemeTableKey, entity.toMap());
    return updatedRows > 0;
  }
}
