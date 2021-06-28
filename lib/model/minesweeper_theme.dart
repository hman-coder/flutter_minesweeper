import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/config/themes.dart';
import 'package:minesweeper_flutter/constants/colors.dart';
import 'package:minesweeper_flutter/constants/db_keys.dart';
import 'package:minesweeper_flutter/helpers/db_values_converters.dart';

class MinesweeperTheme {
  final ThemeData appTheme;

  final MinesweeperElementTheme flagTheme;

  final MinesweeperElementTheme mineTheme;

  final MinesweeperElementTheme tileTheme;

  final Color backgroundColor;

  final TileAnimation tileAnimation;

  MinesweeperTheme({
    required this.appTheme,
    required this.flagTheme,
    required this.mineTheme,
    required this.tileTheme,
    required this.backgroundColor,
    required this.tileAnimation,
  });

  MinesweeperTheme.initial()
      : this.appTheme = lightThemeData,
        this.flagTheme = MinesweeperElementTheme(
          color: kcElementLightAmber,
          icon: MinesweeperIcons.flag,
        ),
        this.mineTheme = MinesweeperElementTheme(
          color: kcElementLightBlack,
          icon: MinesweeperIcons.mine,
        ),
        this.tileTheme = MinesweeperElementTheme(
          color: kcTileColor,
          icon: MinesweeperIcons.tile,
        ),
        this.backgroundColor = kcBackgroundWhiteColor,
        this.tileAnimation = TileAnimation.normal;

  MinesweeperTheme.fromMap(Map<String, dynamic> map)
      : this.tileAnimation = (map[kkAnimationKey] as String).toTileAnimation(),
        this.backgroundColor = (map[kkBackgroundColorKey] as int).toColor(),
        this.appTheme = (map[kkBackgroundColorKey] as int).toColor().isDark
            ? darkThemeData
            : lightThemeData,
        this.flagTheme = MinesweeperElementTheme(
            color: (map[kkFlagColorKey] as int).toColor(),
            icon: (map[kkFlagIconKey] as String).toMinesweeperIcon()),
        this.mineTheme = MinesweeperElementTheme(
            color: (map[kkMineColorKey] as int).toColor(),
            icon: (map[kkMineIconKey] as String).toMinesweeperIcon()),
        this.tileTheme = MinesweeperElementTheme(
            color: (map[kkMineColorKey] as int).toColor(),
            icon: (map[kkMineIconKey] as String).toMinesweeperIcon());

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map[kkAnimationKey] = this.tileAnimation.toDatabaseString();
    map[kkBackgroundColorKey] = this.backgroundColor.value;
    map[kkMineColorKey] = this.mineTheme.color.value;
    map[kkFlagColorKey] = this.flagTheme.color.value;
    map[kkTileColorKey] = this.tileTheme.color.value;
    map[kkFlagIconKey] = this.flagTheme.icon.toDatabaseString();
    map[kkMineIconKey] = this.mineTheme.icon.toDatabaseString();
    map[kkTileIconKey] = this.tileTheme.icon.toDatabaseString();
    return map;
  }
}

class MinesweeperElementTheme {
  final Color color;

  final IconData icon;

  const MinesweeperElementTheme({required this.color, required this.icon});
  
  MinesweeperElementTheme copyWith({Color? color, IconData? icon}) {
    return MinesweeperElementTheme(color: color ?? this.color, icon: icon?? this.icon);
  }
}

enum TileAnimation { normal }
