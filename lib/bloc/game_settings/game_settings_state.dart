import 'package:equatable/equatable.dart';
import 'package:minesweeper_flutter/model/game_settings.dart';

abstract class GameSettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends GameSettingsState {
    
}

class ReloadedState extends GameSettingsState {
  final GameSettings settings;

  ReloadedState(this.settings);

  @override
  List<Object?> get props => [settings];
}

class MusicOnState extends GameSettingsState {}

class MusicOffState extends GameSettingsState {}

class SFXOnState extends GameSettingsState {}

class SFXOffState extends GameSettingsState {}

class NotificationsOnState extends GameSettingsState {}

class NotificationsOffState extends GameSettingsState {}