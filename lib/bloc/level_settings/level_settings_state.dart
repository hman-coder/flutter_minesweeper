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