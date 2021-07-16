import 'package:minesweeper_flutter/entities/entity.dart';
import 'package:minesweeper_flutter/entities/game_settings_entity.dart';
import 'package:minesweeper_flutter/entities/game_theme_entity.dart';
import 'package:minesweeper_flutter/model/game_settings.dart';
import 'package:minesweeper_flutter/model/game_theme.dart';
import 'package:minesweeper_flutter/services/transformers/model_value_converters.dart';

Entity transformModel(dynamic model) {
  if (model is MinesweeperTheme) return _transformThemeModel(model);
  else if (model is GameSettings) return _transformSettingsModel(model);
  throw Exception("The model you passed doesn't have a transformer");
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
