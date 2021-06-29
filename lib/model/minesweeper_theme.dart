import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/config/themes.dart';
import 'package:minesweeper_flutter/constants/colors.dart';
import 'package:minesweeper_flutter/constants/db_keys.dart';
import 'package:minesweeper_flutter/helpers/db_values_converters.dart';

class MinesweeperTheme extends Equatable {
  final ThemeData appTheme;

  final MinesweeperElementTheme flagTheme;

  final MinesweeperElementTheme mineTheme;

  final MinesweeperElementTheme tileTheme;

  final Color backgroundColor;

  final TileAnimation tileAnimation;

  MinesweeperTheme({
    ThemeData? appTheme,
    required this.flagTheme,
    required this.mineTheme,
    required this.tileTheme,
    required this.backgroundColor,
    required this.tileAnimation,
  }) : this.appTheme =
            appTheme ?? themeOfBackgroundColor(backgroundColor);

  MinesweeperTheme.initial()
      : this.appTheme = themeOfBackgroundColor(kcBackgroundWhiteColor),
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
        this.appTheme = themeOfBackgroundColor(
            (map[kkBackgroundColorKey] as int).toColor()),
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

  MinesweeperTheme copyWith({
    ThemeData? appTheme,
    Color? backgroundColor,
    TileAnimation? tileAnimation,
    MinesweeperElementTheme? mineTheme,
    MinesweeperElementTheme? flagTheme,
    MinesweeperElementTheme? tileTheme,
  }) {
    var ret = MinesweeperTheme(
      appTheme: appTheme,
      flagTheme: flagTheme ?? this.flagTheme,
      mineTheme: mineTheme ?? this.mineTheme,
      tileTheme: tileTheme ?? this.tileTheme,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      tileAnimation: tileAnimation ?? this.tileAnimation,
    );
    return ret;
  }

  @override
  List<Object?> get props => [
        appTheme,
        flagTheme,
        mineTheme,
        tileTheme,
        backgroundColor,
        tileAnimation
      ];
}

class MinesweeperElementTheme extends Equatable {
  final Color color;

  final IconData icon;

  const MinesweeperElementTheme({required this.color, required this.icon});

  MinesweeperElementTheme copyWith({Color? color, IconData? icon}) {
    return MinesweeperElementTheme(
        color: color ?? this.color, icon: icon ?? this.icon);
  }

  @override
  List<Object?> get props => [color, icon];
}

enum TileAnimation { normal }
