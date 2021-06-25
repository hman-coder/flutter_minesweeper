import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/constants/db_keys.dart';

class MinesweeperTheme {
  final Color flagColor;

  final Color mineColor;

  final Color tileColor;

  final Color backgroundColor;

  final IconData flagIcon;

  final IconData mineIcon;

  final IconData tileIcon;

  final String animation;

  MinesweeperTheme({
    required this.flagColor,
    required this.mineColor,
    required this.tileColor,
    required this.backgroundColor,
    required this.flagIcon,
    required this.mineIcon,
    required this.tileIcon,
    required this.animation,
  });

  MinesweeperTheme.initial() :
    this.flagColor = Colors.amber,
    this.mineColor = Colors.black,
    this.tileColor = Colors.transparent,
    this.backgroundColor = Colors.white,
    this.flagIcon = MinesweeperIcons.flag,
    this.mineIcon = MinesweeperIcons.mine,
    this.tileIcon = Icons.circle,
    this.animation = 'animation'
    ;

  MinesweeperTheme.fromMap(Map<String, dynamic> map)
      : this.backgroundColor = Color(map[kkBackgroundColorKey]),
        this.mineColor = Color(map[kkMineColorKey]),
        this.flagColor = Color(map[kkFlagColorKey]),
        this.tileColor = Color(map[kkTileColorKey]),
        this.flagIcon = (map[kkFlagIconKey] as String).toMinesweeperIcon(),
        this.mineIcon = (map[kkMineIconKey] as String).toMinesweeperIcon(),
        this.tileIcon = (map[kkTileIconKey] as String).toMinesweeperIcon(),
        this.animation = map[kkAnimationKey] ?? '';

  MinesweeperTheme copyWith(
      {Color? tileColor,
      Color? mineColor,
      Color? flagColor,
      Color? backgroundColor,
      IconData? mineIcon,
      IconData? flagIcon,
      IconData? tileIcon,
      String? animation}) {
    return MinesweeperTheme(
      animation: animation ?? this.animation,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      flagColor: flagColor ?? this.flagColor,
      flagIcon: flagIcon ?? this.flagIcon,
      mineColor: mineColor ?? this.mineColor,
      mineIcon: mineIcon ?? this.mineIcon,
      tileColor: tileColor ?? this.tileColor,
      tileIcon: tileIcon ?? this.tileIcon,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map[kkAnimationKey] = this.animation;
    map[kkMineColorKey] = this.mineColor.value;
    map[kkFlagColorKey] = this.flagColor.value;
    map[kkTileColorKey] = this.tileColor.value;
    map[kkBackgroundColorKey] = this.backgroundColor.value;
    map[kkFlagIconKey] = this.flagIcon.toAppString();
    map[kkMineIconKey] = this.mineIcon.toAppString();
    map[kkTileIconKey] = this.tileIcon.toAppString();

    return map;
  }
}
