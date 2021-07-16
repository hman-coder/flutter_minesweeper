import 'package:flutter/cupertino.dart';
import 'package:minesweeper_flutter/helpers/context_extensions.dart';

const String kkMinesKey = 'mines';
const String kkHeightKey = 'height';
const String kkWidthKey = 'width';

class LevelSettings {
  final int height;

  final int width;

  final int mines;

  LevelSettings.fromDifficulty(GameDifficulty difficulty)
      : height = difficulty.height,
        width = difficulty.width,
        mines = difficulty.mines;

  const LevelSettings({
    required this.height,
    required this.width,
    required this.mines,
  });

  LevelSettings.fromMap(Map<String, dynamic> map)
      : this.height = map[kkHeightKey],
        this.width = map[kkWidthKey],
        this.mines = map[kkMinesKey];

  LevelSettings copyWith({int? height, int? width, int? mines}) {
    return LevelSettings(
      height: height ?? this.height,
      width: width ?? this.width,
      mines: mines ?? this.mines,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map[kkMinesKey] = this.mines;
    map[kkHeightKey] = this.height;
    map[kkWidthKey] = this.width;
    return map;
  }
}

enum GameMode { standard, endless, run, multiplayer }

extension ModeStrings on GameMode {
  String toAppString(BuildContext context) {
    switch (this) {
      case GameMode.standard:
        return context.localization().standardGameMode;

      case GameMode.endless:
        return context.localization().endlessGameMode;

      case GameMode.run:
        return context.localization().runGameMode;

      case GameMode.multiplayer:
        return context.localization().multiplayerGameMode;
    }
  }

  String description(BuildContext context) {
    switch (this) {
      case GameMode.standard:
        return context.localization().standardGameModeDescription;

      case GameMode.endless:
        return context.localization().endlessGameModeDescription;

      case GameMode.run:
        return context.localization().runGameModeDescription;

      case GameMode.multiplayer:
        return context.localization().multiplayerGameModeDescription;
    }
  }

  String descriptionTitle(BuildContext context) {
    switch (this) {
      case GameMode.standard:
        return context.localization().standardGameModeDescriptionTitle;

      case GameMode.endless:
        return context.localization().endlessGameModeDescriptionTitle;

      case GameMode.run:
        return context.localization().runGameModeDescriptionTitle;

      case GameMode.multiplayer:
        return context.localization().multiplayerGameModeDescriptionTitle;
    }
  }
}

extension ModeDifficulties on GameMode {
  List<GameDifficulty> get difficulties {
    switch (this) {
      case GameMode.standard:
        return GameDifficulty.values;

      case GameMode.run:
        return GameDifficulty.values.toList()..remove(GameDifficulty.custom);

      case GameMode.endless:
      case GameMode.multiplayer:
        return [];
    }
  }
}

enum GameDifficulty { expert, hard, intermediate, easy, beginner, custom }

extension DifficultySettings on GameDifficulty {
  int get mines {
    switch (this) {
      case GameDifficulty.expert:
        return 99;
      case GameDifficulty.hard:
        return 99;
      case GameDifficulty.intermediate:
        return 40;
      case GameDifficulty.easy:
        return 10;
      case GameDifficulty.beginner:
        return 10;
      case GameDifficulty.custom:
        return 0;
    }
  }

  int get height {
    switch (this) {
      case GameDifficulty.expert:
        return 30;

      case GameDifficulty.hard:
        return 30;

      case GameDifficulty.intermediate:
        return 16;

      case GameDifficulty.easy:
        return 10;

      case GameDifficulty.beginner:
        return 10;

      case GameDifficulty.custom:
        return 0;
    }
  }

  int get width {
    switch (this) {
      case GameDifficulty.expert:
        return 16;

      case GameDifficulty.hard:
        return 16;

      case GameDifficulty.intermediate:
        return 13;

      case GameDifficulty.easy:
        return 10;

      case GameDifficulty.beginner:
        return 10;

      case GameDifficulty.custom:
        return 0;
    }
  }
}

extension DiffcultyToString on GameDifficulty {
  String toAppString(BuildContext context) {
    switch (this) {
      case GameDifficulty.expert:
        return context.localization().expert;

      case GameDifficulty.hard:
        return context.localization().hard;

      case GameDifficulty.intermediate:
        return context.localization().intermediate;

      case GameDifficulty.easy:
        return context.localization().easy;

      case GameDifficulty.beginner:
        return context.localization().beginner;

      case GameDifficulty.custom:
        return context.localization().custom;
    }
  }
}
