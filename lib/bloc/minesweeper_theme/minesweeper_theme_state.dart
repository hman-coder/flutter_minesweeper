import 'package:flutter/painting.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';

abstract class MinesweeperThemeState {}

class InitialState extends MinesweeperThemeState {
  final MinesweeperTheme theme;
  
  InitialState() : this.theme= MinesweeperTheme.initial();
}

class BackgroundColorChangeState extends MinesweeperThemeState {
  final Color color;

  BackgroundColorChangeState(this.color);
}

class MineThemeChangedState extends MinesweeperThemeState {
  final MinesweeperElementTheme mineTheme;

  MineThemeChangedState(this.mineTheme);
}

class FlagThemeChangedState extends MinesweeperThemeState {
  final MinesweeperElementTheme flagTheme;

  FlagThemeChangedState(this.flagTheme);
}

class TileThemeChangedState extends MinesweeperThemeState {
  final MinesweeperElementTheme tileTheme;

  TileThemeChangedState(this.tileTheme);
}

class MinesweeperThemeUpdatedState extends MinesweeperThemeState {
  final MinesweeperTheme theme;

  MinesweeperThemeUpdatedState(this.theme);

}