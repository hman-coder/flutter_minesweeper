import 'package:minesweeper_flutter/model/minesweeper_level_settings.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

const String ktnLevelSettingsTableName = "minesweeper_level_settings";

abstract class MinesweeperLevelSettingsRepository {
  Future<MinesweeperLevelSettings?> fetchSettings();  

  Future<bool> updateSettings(MinesweeperLevelSettings settingsEntity);
}

class MinesweeperSqliteSettingsRepository extends MinesweeperLevelSettingsRepository{
  @override
  Future<MinesweeperLevelSettings?> fetchSettings() async {
    var accessor = await SqliteAccessor.accessor;
    List<Map<String, dynamic>?> results = await accessor.fetch(ktnLevelSettingsTableName);
    if(results[0] == null) return null;
    return MinesweeperLevelSettings.fromMap(results[0]!);
  }

  @override
  Future<bool> updateSettings(MinesweeperLevelSettings settingsEntity) async {
    return true;
  }
}