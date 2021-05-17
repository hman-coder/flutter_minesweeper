import 'package:minesweeper_flutter/entities/minesweeper_level_settings_entity.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

const String ktnLevelSettingsTableName = "minesweeper_level_settings";

abstract class MinesweeperLevelSettingsRepository {
  Future<MinesweeperLevelSettingsEntity?> fetchSettings();  

  Future<bool> updateSettings(MinesweeperLevelSettingsEntity settingsEntity);
}

class MinesweeperSqliteSettingsRepository extends MinesweeperLevelSettingsRepository{
  @override
  Future<MinesweeperLevelSettingsEntity?> fetchSettings() async {
    var accessor = await SqliteAccessor.accessor;
    List<Map<String, dynamic>?> results = await accessor.fetch(ktnLevelSettingsTableName);
    if(results[0] == null) return null;
    return MinesweeperLevelSettingsEntity.fromMap(results[0]!);
  }

  @override
  Future<bool> updateSettings(MinesweeperLevelSettingsEntity settingsEntity) async {
    return true;
  }
}