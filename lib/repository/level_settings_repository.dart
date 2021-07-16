import 'package:minesweeper_flutter/model/level_settings.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

const String ktnLevelSettingsTableName = "minesweeper_level_settings";

abstract class LevelSettingsRepository {
  Future<LevelSettings?> fetchSettings();  

  Future<bool> updateSettings(LevelSettings settingsEntity);
}

class LevelSettingsSqliteRepository extends LevelSettingsRepository{
  @override
  Future<LevelSettings?> fetchSettings() async {
    var accessor = await SqliteAccessor.accessor;
    List<Map<String, dynamic>?> results = await accessor.fetch(ktnLevelSettingsTableName);
    if(results[0] == null) return null;
    return LevelSettings.fromMap(results[0]!);
  }

  @override
  Future<bool> updateSettings(LevelSettings settingsEntity) async {
    return true;
  }
}