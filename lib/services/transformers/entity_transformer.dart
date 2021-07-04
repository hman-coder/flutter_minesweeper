import 'package:minesweeper_flutter/entities/game_settings_entity.dart';
import 'package:minesweeper_flutter/entities/minesweeper_theme_entity.dart';
import 'package:minesweeper_flutter/model/game_settings.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/services/transformers/db_values_converters.dart';

dynamic transformEntity(dynamic entity) {
  if (entity is MinesweeperThemeEntity) return _themeEntityTransformer(entity);
  else if (entity is GameSettingsEntity) return _settingsEntityTransformer(entity);
}

MinesweeperTheme _themeEntityTransformer(MinesweeperThemeEntity entity) {
  var mineTheme = MinesweeperElementTheme(
      color: entity.mineColorValue.toColor(),
      icon: entity.mineIcon.toMinesweeperIcon());
  var flagTheme = MinesweeperElementTheme(
      color: entity.flagColorValue.toColor(),
      icon: entity.flagIcon.toMinesweeperIcon());
  var tileTheme = MinesweeperElementTheme(
      color: entity.tileColorValue.toColor(),
      icon: entity.tileIcon.toMinesweeperIcon());

  return MinesweeperTheme(
    backgroundColor: entity.backgroundColorValue.toColor(),
    flagTheme: flagTheme,
    mineTheme: mineTheme,
    tileTheme: tileTheme,
    tileAnimation: entity.tileAnimation.toTileAnimation(),
  );
}

GameSettings _settingsEntityTransformer(GameSettingsEntity entity) {
  return GameSettings(
    music: entity.music > 0,
    sfx: entity.sfx > 0,
    notifications: entity.notifications > 0,
  );
}
