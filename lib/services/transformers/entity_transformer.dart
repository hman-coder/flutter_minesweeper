import 'package:minesweeper_flutter/entities/game_settings_entity.dart';
import 'package:minesweeper_flutter/entities/game_theme_entity.dart';
import 'package:minesweeper_flutter/entities/level_settings_entity.dart';
import 'package:minesweeper_flutter/model/game_settings.dart';
import 'package:minesweeper_flutter/model/game_theme.dart';
import 'package:minesweeper_flutter/model/level_settings.dart';
import 'package:minesweeper_flutter/services/transformers/entity_value_converters.dart';

dynamic transformEntity(dynamic entity) {
  if(entity == null) return null;
  if (entity is GameThemeEntity) return _themeEntityTransformer(entity);
  else if (entity is GameSettingsEntity) return _settingsEntityTransformer(entity);
}

MinesweeperTheme _themeEntityTransformer(GameThemeEntity entity) {
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

LevelSettings _levelSettingsEntityTransformer(LevelSettingsEntity entity) {
  return LevelSettings(
    mines: entity.mines,
    height: entity.height,
    width: entity.width,
    difficulty: entity.difficulty.toDifficulty(),
    mode: entity.gameMode.toGameMode()
  );
}