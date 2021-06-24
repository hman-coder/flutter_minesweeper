import 'package:minesweeper_flutter/constants/db_keys.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

abstract class MinesweeperThemeRepository {
  Future<MinesweeperTheme> fetchTheme();

  Future<bool> update(MinesweeperTheme theme);
}

class MinesweeperThemeSqliteRepository extends MinesweeperThemeRepository {
  @override
  Future<MinesweeperTheme> fetchTheme() async {
    var accessor = await SqliteAccessor.accessor;
    var results = await accessor.fetch(kkMinesweeperThemeTableKey);
    var entity = MinesweeperTheme.fromMap(results[0]!);
    return entity;
  }

  @override
  Future<bool> update(MinesweeperTheme theme) async {
    var accessor = await SqliteAccessor.accessor;
    int updatedRows =  await accessor.updateSettings(kkMinesweeperThemeTableKey, theme.toMap());
    return updatedRows > 0;
  }
}