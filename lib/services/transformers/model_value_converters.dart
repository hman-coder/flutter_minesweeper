import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/model/level_settings.dart';
import 'package:minesweeper_flutter/model/game_theme.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/constants/db_default_values.dart';

/// A class containing methods that convert values obtained
/// from the database to app models, and vice versa.

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
    } else if (this.fontFamily == MinesweeperIcons.tile.fontFamily &&
        this.codePoint == MinesweeperIcons.tile.codePoint)
      return kvTileDefaultIconValue;

    throw Exception("This icon data is not of MinesweeperIcons.");
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

extension GameModeToString on GameMode {
  String toDatabaseString() {
    switch (this) {
      case GameMode.standard:
        return kvStandardGameMode;

      case GameMode.endless:
        return kvEndlessGameMode;

      case GameMode.run:
        return kvRunGameMode;

      case GameMode.multiplayer:
        return kvMultiplayerGameMode;
    }
  }
}

extension DifficultyToString on GameDifficulty {
  String toDatabaseString() {
    switch(this) {
      case GameDifficulty.expert:
        return kvExpertGameDifficulty;
        
      case GameDifficulty.hard:
        return kvHardGameDifficulty;

      case GameDifficulty.intermediate:
        return kvIntermediateGameDifficulty;

      case GameDifficulty.easy:
        return kvEasyGameDifficulty;
        
      case GameDifficulty.beginner:
        return kvBeginnerGameDifficulty;

      case GameDifficulty.custom:
        return kvCustomGameDifficulty;
    }
  }
}
