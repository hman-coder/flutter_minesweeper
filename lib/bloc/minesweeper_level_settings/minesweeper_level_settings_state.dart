import 'package:equatable/equatable.dart';
import 'package:minesweeper_flutter/model/minesweeper_level_settings.dart';

abstract class MinesweeperLevelSettingsState with EquatableMixin {
  const MinesweeperLevelSettingsState();

  @override
  List<Object?> get props => [];
}

class InitialState extends MinesweeperLevelSettingsState {}

class LoadingState extends MinesweeperLevelSettingsState{}

class SettingsUpdatedState extends MinesweeperLevelSettingsState{
  final MinesweeperLevelSettings newSettings;

  SettingsUpdatedState(this.newSettings);

  @override
  List<Object?> get props => [newSettings];
}