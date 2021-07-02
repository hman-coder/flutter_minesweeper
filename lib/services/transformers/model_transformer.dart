import 'package:minesweeper_flutter/entities/minesweeper_theme_entity.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/helpers/db_values_converters.dart';

dynamic transformModel(dynamic model) {
  if (model is MinesweeperTheme) return _transformThemeModel(model);
}

MinesweeperThemeEntity _transformThemeModel(MinesweeperTheme model) {
  return MinesweeperThemeEntity(
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
