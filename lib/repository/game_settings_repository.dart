import 'package:minesweeper_flutter/model/game_settings.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';

const String _tableName = "game_settings";

abstract class GameSettingsRepository {
  Future<GameSettings> fetch();
}

class GameSettingsSqliteRepository extends GameSettingsRepository {
  @override
  Future<GameSettings> fetch() async {
    var accessor = await SqliteAccessor.accessor;
    var data = await accessor.fetch(_tableName);
    if(data[0] == null) throw Exception("Fetching game settings resulted in a null response.");
    else return GameSettings.fromMap(data[0]!);
  }

}