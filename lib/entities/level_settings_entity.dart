import 'package:equatable/equatable.dart';
import 'package:minesweeper_flutter/constants/db_keys.dart';
import 'package:minesweeper_flutter/entities/entity.dart';

/// Represents the last chosen settings by the user
class LevelSettingsEntity extends Entity with EquatableMixin {
  final int height;

  final int width;

  final int mines;

  final String gameMode;

  final String difficulty;

  LevelSettingsEntity.fromMap(Map<String, dynamic> map)
      : height = map[kkHeight],
        width = map[kkWidth],
        mines = map[kkMines],
        gameMode = map[kkGameMode],
        difficulty = map[kkGameDifficulty],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map[kkHeight] = this.height;
    map[kkWidth] = this.width;
    map[kkMines] = this.mines;
    map[kkGameMode] = this.gameMode;
    map[kkGameDifficulty] = this.difficulty;
    return map;
  }
  
  @override
  List<Object?> get props => [height, width, mines, gameMode, difficulty];

}
