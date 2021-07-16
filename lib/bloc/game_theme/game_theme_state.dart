import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:minesweeper_flutter/model/game_theme.dart';

abstract class GameThemeState extends Equatable {
}

class InitialState extends GameThemeState {
  final MinesweeperTheme theme;
  
  InitialState() : this.theme= MinesweeperTheme.initial();

  @override
  List<Object?> get props => [theme];
}

class ThemeReloadedState extends GameThemeState{
  final MinesweeperTheme theme;

  ThemeReloadedState(this.theme);

  @override
  List<Object?> get props => [theme];
}

class BackgroundColorUpdatedState extends GameThemeState {
  final Color color;

  BackgroundColorUpdatedState(this.color);

  @override
  List<Object?> get props => [color];
}

class MineThemeUpdatedState extends GameThemeState {
  final MinesweeperElementTheme mineTheme;

  MineThemeUpdatedState(this.mineTheme);

  @override
  List<Object?> get props => [mineTheme];
}

class FlagThemeUpdatedState extends GameThemeState {
  final MinesweeperElementTheme flagTheme;

  FlagThemeUpdatedState(this.flagTheme);

  @override
  List<Object?> get props => [flagTheme];
}

class TileThemeUpdatedState extends GameThemeState {
  final MinesweeperElementTheme tileTheme;

  TileThemeUpdatedState(this.tileTheme);

  @override
  List<Object?> get props => [tileTheme];
}

class TileAnimationUpdatedState extends GameThemeState {
  final TileAnimation animation;

  TileAnimationUpdatedState(this.animation);

  @override
  List<Object?> get props => [animation];
  
}

class MinesweeperThemeUpdatedState extends GameThemeState {
  final MinesweeperTheme theme;

  MinesweeperThemeUpdatedState(this.theme);

  @override
  List<Object?> get props => [theme];
}

class ErrorState extends GameThemeState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}