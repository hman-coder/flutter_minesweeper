import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/model/game_theme.dart';

abstract class GameThemeEvent implements Equatable {
  bool get stringify => true;
}

class ReloadEvent extends GameThemeEvent {
  @override
  List<Object?> get props => [];
}

class BackgroundColorChangeEvent extends GameThemeEvent {
  final Color color;

  BackgroundColorChangeEvent(this.color);

  @override
  List<Object?> get props => [color];
}

class FlagThemeChangeEvent extends GameThemeEvent {
  final Color? color;

  final IconData? icon;

  FlagThemeChangeEvent({this.color, this.icon})
      : assert(color != null || icon != null,
            "You must provide either a color or an icon in a theme change event");

  @override
  List<Object?> get props => [color, icon];
}

class MineThemeChangeEvent extends GameThemeEvent {
  final Color? color;

  final IconData? icon;

  MineThemeChangeEvent({this.color, this.icon})
      : assert(color != null || icon != null,
            "You must provide either a color or an icon in a theme change event");

  @override
  List<Object?> get props => [color, icon];
}

class TileThemeChangeEvent extends GameThemeEvent {
  final Color? color;

  final IconData? icon;

  TileThemeChangeEvent({this.color, this.icon})
      : assert(color != null || icon != null,
            "You must provide either a color or an icon in a theme change event");

  @override
  List<Object?> get props => [color, icon];
}

class TileAnimationChangeEvent extends GameThemeEvent {
  final TileAnimation animation;

  TileAnimationChangeEvent(this.animation);

  @override
  List<Object?> get props => [animation];
}
