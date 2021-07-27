import 'package:minesweeper_flutter/constants/db_keys.dart';
import 'package:minesweeper_flutter/entities/level_settings_entity.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

abstract class LevelSettingsRepository {
  Future<LevelSettingsEntity?> fetchSettings();  

  Future<bool> updateSettings(LevelSettingsEntity settingsEntity);
}

class LevelSettingsSqliteRepository extends LevelSettingsRepository{
  @override
  Future<LevelSettingsEntity?> fetchSettings() async {
    var accessor = await SqliteAccessor.accessor;
    List<Map<String, dynamic>?> results = await accessor.fetch(kkLevelSettingsTableKey);
    if(results[0] == null) return null;
    return LevelSettingsEntity.fromMap(results[0]!);
  }

  @override
  Future<bool> updateSettings(LevelSettingsEntity settingsEntity) async {
    var accessor = await SqliteAccessor.accessor;
    int updatedRows =  await accessor.updateSettings(kkLevelSettingsTableKey, settingsEntity.toMap());
    return updatedRows > 0;
  }
}