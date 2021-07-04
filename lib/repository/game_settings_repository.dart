import 'package:minesweeper_flutter/constants/db_keys.dart';
import 'package:minesweeper_flutter/entities/game_settings_entity.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

abstract class GameSettingsRepository {
  Future<GameSettingsEntity> fetch();

  Future<bool> update(GameSettingsEntity settings);
}

class GameSettingsSqliteRepository extends GameSettingsRepository {
  @override
  Future<GameSettingsEntity> fetch() async {
    var accessor = await SqliteAccessor.accessor;
    var data = await accessor.fetch(kkGameSettingsTableName);
    return GameSettingsEntity.fromMap(data[0]!);
  }

  @override
  Future<bool> update(GameSettingsEntity settings) async {
    var accessor = await SqliteAccessor.accessor;
    int updatedRows =  await accessor.updateSettings(kkGameSettingsTableName, settings.toMap());
    return updatedRows > 0;
  }


}