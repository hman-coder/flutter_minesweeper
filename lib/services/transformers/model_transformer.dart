import 'package:minesweeper_flutter/entities/entity.dart';
import 'package:minesweeper_flutter/entities/game_settings_entity.dart';
import 'package:minesweeper_flutter/entities/game_theme_entity.dart';
import 'package:minesweeper_flutter/entities/level_settings_entity.dart';
import 'package:minesweeper_flutter/model/game_settings.dart';
import 'package:minesweeper_flutter/model/game_theme.dart';
import 'package:minesweeper_flutter/model/level_settings.dart';
import 'package:minesweeper_flutter/services/transformers/model_value_converters.dart';

T transformModel<T extends Entity>(dynamic model) {
  if (model is MinesweeperTheme)
    return _transformThemeModel(model) as T;
  else if (model is GameSettings)
    return _transformSettingsModel(model) as T;
  else if (model is LevelSettings) return _transformLevelSettings(model) as T;
  throw Exception(
      "The model you passed (type ${model.runtimeType}) doesn't have a transformer");
}

GameThemeEntity _transformThemeModel(MinesweeperTheme model) {
  return GameThemeEntity(
    backgroundColorValue: model.backgroundColor.value,
    tileAnimation: model.tileAnimation.toDatabaseString(),
    mineColorValue: model.mineTheme.color.value,
    flagColorValue: model.flagTheme.color.value,
    tileColorValue: model.tileTheme.color.value,
    mineIcon: model.mineTheme.icon.toDatabaseString(),
    flagIcon: model.flagTheme.icon.toDatabaseString(),
    tileIcon: model.tileTheme.icon.toDatabaseString(),
  );
}

GameSettingsEntity _transformSettingsModel(GameSettings model) {
  return GameSettingsEntity(
    music: model.music ? 1 : 0,
    sfx: model.sfx ? 1 : 0,
    notifications: model.notifications ? 1 : 0,
  );
}

LevelSettingsEntity _transformLevelSettings(LevelSettings model) {
  return LevelSettingsEntity(
      height: model.height,
      width: model.width,
      mines: model.mines,
      gameMode: model.mode.toDatabaseString(),
      difficulty: model.difficulty.toDatabaseString());
}
