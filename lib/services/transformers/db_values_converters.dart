import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/constants/db_default_values.dart';

/// A class containing methods that convert values obtained
/// from the database to app models, and vice versa.

extension IntToColor on int {
  Color toColor() => Color(this);
}

extension MinesweeperIconToString on IconData {
  String toDatabaseString() {
    if (this.fontFamily == kFontFam) {
      switch (this.codePoint) {
        case kcpMineCodePoint:
          return kvMineDefaultIconValue;

        case kcpMineRelaxedCodePoint:
          return kvMineRelaxedIconValue;

        case kcpFlagCodePoint:
          return kvFlagDefaultIconValue;
      }
    } else if(this.fontFamily == MinesweeperIcons.tile.fontFamily && this.codePoint == MinesweeperIcons.tile.codePoint)
      return kvTileDefaultIconValue;

    throw Exception("This icon data is not of MinesweeperIcons.");
  }
}

extension StringToMinesweeperIcon on String {
    IconData toMinesweeperIcon() {
    switch (this) {
      case kvMineDefaultIconValue:
        return MinesweeperIcons.mine;

      case kvFlagDefaultIconValue:
        return MinesweeperIcons.flag;

      case kvMineRelaxedIconValue:
        return MinesweeperIcons.mine_relaxed;

      case kvTileDefaultIconValue:
        return MinesweeperIcons.tile;
    }

    throw Exception("This String does not represet a MinesweeperIcons constant.");
  }
}

extension TileAnimationToString on TileAnimation {
  String toDatabaseString() {
    switch (this) {
      case TileAnimation.normal:
        return 'normal';
      case TileAnimation.test:
        return 'test';

    }
  }
}

extension StringToTileAnimation on String {
  TileAnimation toTileAnimation() {
    switch (this) {
      case 'normal':
        return TileAnimation.normal;
    }

    throw Exception("The given string is not a TileAnimation representation");
  }
}
