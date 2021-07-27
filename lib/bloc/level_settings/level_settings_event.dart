import 'package:equatable/equatable.dart';
import 'package:minesweeper_flutter/model/level_settings.dart';

abstract class LevelSettingsEvent with EquatableMixin {
  const LevelSettingsEvent();

  @override
  List<Object?> get props => [];
}

class ReloadEvent extends LevelSettingsEvent {}

class HeightChangedEvent extends LevelSettingsEvent {
  final int height;

  const HeightChangedEvent(this.height);

  @override
  List<Object?> get props => [height];
}

class WidthChangedEvent extends LevelSettingsEvent {
  final int width;

  const WidthChangedEvent(this.width);

  @override
  List<Object?> get props => [width];
}

class MinesChangedEvent extends LevelSettingsEvent {
  final int mines;

  const MinesChangedEvent(this.mines);

  @override
  List<Object?> get props => [mines];
}

class DifficultyChangedEvent extends LevelSettingsEvent {
  final GameDifficulty difficulty;

  const DifficultyChangedEvent(this.difficulty);

  @override
  List<Object?> get props => [difficulty];
}

class GameModeChangedEvent extends LevelSettingsEvent {
  final GameMode mode;

  const GameModeChangedEvent(this.mode);

  @override
  List<Object?> get props => [mode];
}