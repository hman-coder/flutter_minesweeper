import 'package:equatable/equatable.dart';

abstract class LevelSettingsEvent with EquatableMixin {

  const LevelSettingsEvent();

  @override
  List<Object?> get props => [];
}

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

class ReloadEvent extends LevelSettingsEvent {
  
}