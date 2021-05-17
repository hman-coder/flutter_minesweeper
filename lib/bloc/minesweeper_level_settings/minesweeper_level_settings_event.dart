import 'package:equatable/equatable.dart';

abstract class MinesweeperLevelSettingsEvent with EquatableMixin {

  const MinesweeperLevelSettingsEvent();

  @override
  List<Object?> get props => [];
}

class HeightChangedEvent extends MinesweeperLevelSettingsEvent {
  final int height;

  const HeightChangedEvent(this.height);

  @override
  List<Object?> get props => [height];
}

class WidthChangedEvent extends MinesweeperLevelSettingsEvent {
  final int width;

  const WidthChangedEvent(this.width);

  @override
  List<Object?> get props => [width];
}

class MinesChangedEvent extends MinesweeperLevelSettingsEvent {
  final int mines;

  const MinesChangedEvent(this.mines);

  @override
  List<Object?> get props => [mines];
}

class ReloadEvent extends MinesweeperLevelSettingsEvent {
  
}