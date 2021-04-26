import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/entities/minesweeper_theme_entity.dart';

class MinesweeperTheme {
  final Color tileBackgroundColor;

  /// The color of mine/flag
  final Color foregroundColor;

  final String flagIconPath;

  final String mineIconPath;

  final String animation;

  final MinesweeperTileShape tileShape;

  MinesweeperTheme({
    this.animation = '',
    this.foregroundColor = Colors.black,
    this.tileBackgroundColor = Colors.white,
    this.flagIconPath = "flag.png",
    this.mineIconPath = "mine.png",
    this.tileShape = MinesweeperTileShape.circle,
  });

  MinesweeperTheme.fromEntity(MinesweeperThemeEntity entity)
      : flagIconPath = entity.flagIconPath,
        mineIconPath = entity.mineIconPath,
        tileShape = MinesweeperTileShapeExtension.fromString(entity.tileShape),
        foregroundColor = Color(entity.foregroundColorValue),
        tileBackgroundColor = Color(entity.tileBackgroundColorValue),
        animation = entity.animation;

  MinesweeperTheme copyWith({Color? tileBackgroundColor, String? flagIconPath,
      String? mineIconPath, MinesweeperTileShape? tileShape}) {
    return MinesweeperTheme(
      tileBackgroundColor: tileBackgroundColor ?? this.tileBackgroundColor,
      flagIconPath: flagIconPath ?? this.flagIconPath,
      mineIconPath: mineIconPath ?? this.mineIconPath,
      tileShape: tileShape ?? this.tileShape,
    );
  }
}

enum MinesweeperTileShape {
  circle,
  square,
}

extension MinesweeperTileShapeExtension on MinesweeperTileShape {
  String toSimpleString() {
    switch (this) {
      case MinesweeperTileShape.circle:
        return 'circle';
      case MinesweeperTileShape.square:
        return 'square';
    }
  }

  static MinesweeperTileShape fromString(String s) {
    switch (s) {
      case 'circle':
        return MinesweeperTileShape.circle;

      case 'square':
        return MinesweeperTileShape.square;

      default:
        return MinesweeperTileShape.circle;
    }
  }
}
