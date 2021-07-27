import 'package:equatable/equatable.dart';
import 'package:minesweeper_flutter/model/level_settings.dart';

abstract class LevelSettingsState with EquatableMixin {
  const LevelSettingsState();

  @override
  List<Object?> get props => [];
}

class InitialState extends LevelSettingsState {}

class LoadingState extends LevelSettingsState{}

class SettingsUpdatedState extends LevelSettingsState{
  final LevelSettings newSettings;

  SettingsUpdatedState(this.newSettings);

  @override
  List<Object?> get props => [newSettings];
}

class HeightUpdatedState extends LevelSettingsState{
  final int height;

  HeightUpdatedState(this.height);

  @override
  List<Object?> get props => [height];
}

class WidthUpdatedState extends LevelSettingsState{
  final int width;

  WidthUpdatedState(this.width);

  @override
  List<Object?> get props => [width];
}

class MinesUpdatedState extends LevelSettingsState{
  final int mines;

  MinesUpdatedState(this.mines);

  @override
  List<Object?> get props => [mines];
}

class DifficultyUpdatedState extends LevelSettingsState {
  final GameDifficulty difficulty;

  DifficultyUpdatedState(this.difficulty);

  @override
  List<Object?> get props => [difficulty];
}

class GameModeUpdatedState extends LevelSettingsState {
  final GameMode mode;

  GameModeUpdatedState(this.mode);

  @override
  List<Object?> get props => [mode];
}