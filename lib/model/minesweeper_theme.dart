import 'package:flutter/material.dart';

const String kkForegroundColorKey = "foreground_color";
const String kkAnimationKey = "animation";
const String kkBackgroundColorKey = "background_color";
const String kkFlagIconKey = "flag_icon";
const String kkMineIconKey = "mine_icon";
const String kkTileShapeKey = "tile_shape";

class MinesweeperTheme {
  final Color tileBackgroundColor;

  /// The color of mine/flag
  final Color foregroundColor;

  final String flagIconPath;

  final String mineIconPath;

  final String animation;

  final MinesweeperTileShape tileShape;

  const MinesweeperTheme({
    this.animation = '',
    this.foregroundColor = Colors.black,
    this.tileBackgroundColor = Colors.white,
    this.flagIconPath = "flag.png",
    this.mineIconPath = "mine.png",
    this.tileShape = MinesweeperTileShape.circle,
  });

  MinesweeperTheme.fromMap(Map<String, dynamic> map)
      : this.foregroundColor = Color(map[kkForegroundColorKey]),
        this.animation = map[kkAnimationKey] ?? '',
        this.tileBackgroundColor = Color(map[kkBackgroundColorKey]),
        this.flagIconPath = map[kkFlagIconKey],
        this.mineIconPath = map[kkMineIconKey],
        this.tileShape = (map[kkTileShapeKey] as String).toMinesweeperTileShape();

  MinesweeperTheme copyWith(
      {Color? tileBackgroundColor,
      String? flagIconPath,
      String? mineIconPath,
      MinesweeperTileShape? tileShape}) {
    return MinesweeperTheme(
      tileBackgroundColor: tileBackgroundColor ?? this.tileBackgroundColor,
      flagIconPath: flagIconPath ?? this.flagIconPath,
      mineIconPath: mineIconPath ?? this.mineIconPath,
      tileShape: tileShape ?? this.tileShape,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map[kkForegroundColorKey] = foregroundColor.value;
    map[kkBackgroundColorKey] = tileBackgroundColor.value;
    map[kkAnimationKey] = animation;
    map[kkFlagIconKey] = flagIconPath;
    map[kkMineIconKey] = mineIconPath;
    map[kkTileShapeKey] = tileShape.toSimpleString();
    return map;
  }

}

enum MinesweeperTileShape {
  circle,
  square,
}

extension MinesweeperTileShapeToString on MinesweeperTileShape {
  String toSimpleString() {
    switch (this) {
      case MinesweeperTileShape.circle:
        return 'circle';
      case MinesweeperTileShape.square:
        return 'square';
    }
  }

  
}

extension StringToMinesweeperTileShape on String {
  MinesweeperTileShape toMinesweeperTileShape() {
    switch (this) {
      case 'circle':
        return MinesweeperTileShape.circle;

      case 'square':
        return MinesweeperTileShape.square;

      default:
        return MinesweeperTileShape.circle;
    }
  }
}