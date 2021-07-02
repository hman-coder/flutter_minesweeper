import 'package:minesweeper_flutter/entities/minesweeper_theme_entity.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/helpers/db_values_converters.dart';

dynamic transformEntity(dynamic entity) {
  if (entity is MinesweeperThemeEntity) return _themeEntityTransformer(entity);
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
