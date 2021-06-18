import 'package:minesweeper_flutter/constants/db_keys.dart';
import 'package:minesweeper_flutter/model/game_settings.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

abstract class GameSettingsRepository {
  Future<GameSettings> fetch();

  Future<void> update(GameSettings settings);
}

class GameSettingsSqliteRepository extends GameSettingsRepository {
  @override
  Future<GameSettings> fetch() async {
    var accessor = await SqliteAccessor.accessor;
    var data = await accessor.fetch(ksGameSettingsTableName);
    return GameSettings.fromMap(data[0]!);
  }

  @override
  Future<bool> update(GameSettings settings) async {
    var accessor = await SqliteAccessor.accessor;
    int updatedRows =  await accessor.updateSettings(ksGameSettingsTableName, settings.toMap());
    return updatedRows > 0;
  }


}