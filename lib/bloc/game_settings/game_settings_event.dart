import 'package:equatable/equatable.dart';

abstract class GameSettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReloadEvent extends GameSettingsEvent {}

class ToggleMusicEvent extends GameSettingsEvent {}

class ToggleSFXEvent extends GameSettingsEvent {}

class ToggleNotificationsEvent extends GameSettingsEvent {}