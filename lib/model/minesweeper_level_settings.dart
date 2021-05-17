import 'package:minesweeper_flutter/entities/minesweeper_level_settings_entity.dart';

class MinesweeperLevelSettings {
  final int height;

  final int width;

  final int mines;

  MinesweeperLevelSettings.beginner({
    this.height = 10,
    this.width = 10,
    this.mines = 10,
  });

  MinesweeperLevelSettings.intermediate({
    this.height = 16,
    this.width = 13,
    this.mines = 40,
  });

  MinesweeperLevelSettings.expert({
    this.height = 30,
    this.width = 16,
    this.mines = 99,
  });

  MinesweeperLevelSettings.custom({
    required this.height,
    required this.width,
    required this.mines,
  });

  MinesweeperLevelSettings.fromEntity(
      {required MinesweeperLevelSettingsEntity entity})
      : this.height = entity.height,
        this.width = entity.width,
        this.mines = entity.mines;

  MinesweeperLevelSettings copyWith({int? height, int? width, int? mines}) {
    return MinesweeperLevelSettings.custom(
      height: height ?? this.height,
      width: width ?? this.width,
      mines: mines ?? this.mines,
    );
  }

  MinesweeperLevelSettingsEntity toEntity() {
    return MinesweeperLevelSettingsEntity(
      mines: this.mines,
      height: this.height,
      width: this.width,
    );
  }
}
