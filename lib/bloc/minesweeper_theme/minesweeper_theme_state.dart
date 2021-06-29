import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';

abstract class MinesweeperThemeState extends Equatable {
}

class InitialState extends MinesweeperThemeState {
  final MinesweeperTheme theme;
  
  InitialState() : this.theme= MinesweeperTheme.initial();

  @override
  List<Object?> get props => [theme];
}

class ThemeReloadedState extends MinesweeperThemeState{
  final MinesweeperTheme theme;

  ThemeReloadedState(this.theme);

  @override
  List<Object?> get props => [theme];
}

class BackgroundColorUpdatedState extends MinesweeperThemeState {
  final Color color;

  BackgroundColorUpdatedState(this.color);

  @override
  List<Object?> get props => [color];
}

class MineThemeUpdatedState extends MinesweeperThemeState {
  final MinesweeperElementTheme mineTheme;

  MineThemeUpdatedState(this.mineTheme);

  @override
  List<Object?> get props => [mineTheme];
}

class FlagThemeUpdatedState extends MinesweeperThemeState {
  final MinesweeperElementTheme flagTheme;

  FlagThemeUpdatedState(this.flagTheme);

  @override
  List<Object?> get props => [flagTheme];
}

class TileThemeUpdatedState extends MinesweeperThemeState {
  final MinesweeperElementTheme tileTheme;

  TileThemeUpdatedState(this.tileTheme);

  @override
  List<Object?> get props => [tileTheme];
}

class TileAnimationUpdatedState extends MinesweeperThemeState {
  final TileAnimation animation;

  TileAnimationUpdatedState(this.animation);

  @override
  List<Object?> get props => [animation];
  
}

class MinesweeperThemeUpdatedState extends MinesweeperThemeState {
  final MinesweeperTheme theme;

  MinesweeperThemeUpdatedState(this.theme);

  @override
  List<Object?> get props => [theme];
}

class ErrorState extends MinesweeperThemeState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}