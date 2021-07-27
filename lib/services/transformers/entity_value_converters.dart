import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/constants/db_default_values.dart';
import 'package:minesweeper_flutter/model/level_settings.dart';
import 'package:minesweeper_flutter/model/game_theme.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';

extension IntToColor on int {
  Color toColor() => Color(this);
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

    throw Exception(
        "This String does not represet a MinesweeperIcons constant.");
  }
}

extension StringToTileAnimation on String {
  TileAnimation toTileAnimation() {
    switch (this) {
      case 'normal':
        return TileAnimation.normal;
    }

    throw Exception("The given string ($this) is not a TileAnimation representation");
  }
}

extension StringToGameMode on String {
  GameMode toGameMode() {
    switch (this) {
      case kvRunGameMode:
        return GameMode.run;

      case kvEndlessGameMode:
        return GameMode.endless;

      case kvStandardGameMode:
        return GameMode.standard;

      case kvMultiplayerGameMode:
        return GameMode.multiplayer;
    }

    throw Exception("The given string is not a GameMode representation");
  }
}

extension StringToDifficulty on String {
  GameDifficulty toDifficulty() {
    switch (this) {
      case kvEasyGameDifficulty:
        return GameDifficulty.easy;

      case kvBeginnerGameDifficulty:
        return GameDifficulty.beginner;

      case kvIntermediateGameDifficulty:
        return GameDifficulty.intermediate;

      case kvHardGameDifficulty:
        return GameDifficulty.hard;
        
      case kvExpertGameDifficulty:
        return GameDifficulty.expert;
    }

    throw Exception("The given string is not a GameDifficulty representation");
  }
}
