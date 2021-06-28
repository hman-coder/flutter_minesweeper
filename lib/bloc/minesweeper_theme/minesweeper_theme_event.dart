import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';

abstract class MinesweeperThemeEvent {}

class ReloadEvent extends MinesweeperThemeEvent {

}

class BackgroundColorChangeEvent extends MinesweeperThemeEvent {
  final Color color;

  BackgroundColorChangeEvent(this.color);
}

class FlagThemeChangeEvent extends MinesweeperThemeEvent{
  final Color? color;

  final IconData? icon;

  FlagThemeChangeEvent({this.color, this.icon})
      : assert(color != null || icon != null,
            "You must provide either a color or an icon in a theme change event");
}

class MineThemeChangeEvent extends MinesweeperThemeEvent{
  final Color? color;

  final IconData? icon;

  MineThemeChangeEvent({this.color, this.icon})
      : assert(color != null || icon != null,
            "You must provide either a color or an icon in a theme change event");
}

class TileThemeChangeEvent extends MinesweeperThemeEvent{
  final Color? color;

  final IconData? icon;

  TileThemeChangeEvent({this.color, this.icon})
      : assert(color != null || icon != null,
            "You must provide either a color or an icon in a theme change event");
}

class TileAnimationChangeEvent extends MinesweeperThemeEvent {
  final TileAnimation animation;

  TileAnimationChangeEvent(this.animation);
  
}