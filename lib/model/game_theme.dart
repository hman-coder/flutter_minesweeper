import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/constants/colors.dart';

class MinesweeperTheme extends Equatable {

  final MinesweeperElementTheme flagTheme;

  final MinesweeperElementTheme mineTheme;

  final MinesweeperElementTheme tileTheme;

  final Color backgroundColor;

  final TileAnimation tileAnimation;

  ThemeMode get themeMode => isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  
  bool get isDarkTheme => darkBackgroundColors.contains(backgroundColor);

  MinesweeperTheme({
    required this.flagTheme,
    required this.mineTheme,
    required this.tileTheme,
    required this.backgroundColor,
    required this.tileAnimation,
  });

  MinesweeperTheme.initial()
      : this.flagTheme = MinesweeperElementTheme(
          color: kcLightModeElementAmber,
          icon: MinesweeperIcons.flag,
        ),
        this.mineTheme = MinesweeperElementTheme(
          color: kcLightModeElementBlack,
          icon: MinesweeperIcons.mine,
        ),
        this.tileTheme = MinesweeperElementTheme(
          color: kcTileColor,
          icon: MinesweeperIcons.tile,
        ),
        this.backgroundColor = kcLightModeBackgroundWhite,
        this.tileAnimation = TileAnimation.normal;

  MinesweeperTheme copyWith({
    Color? backgroundColor,
    TileAnimation? tileAnimation,
    MinesweeperElementTheme? mineTheme,
    MinesweeperElementTheme? flagTheme,
    MinesweeperElementTheme? tileTheme,
  }) {
    var ret = MinesweeperTheme(
      flagTheme: flagTheme ?? this.flagTheme,
      mineTheme: mineTheme ?? this.mineTheme,
      tileTheme: tileTheme ?? this.tileTheme,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      tileAnimation: tileAnimation ?? this.tileAnimation,
    );
    return ret;
  }

  @override
  List<Object?> get props => [
        flagTheme,
        mineTheme,
        tileTheme,
        backgroundColor,
        tileAnimation
      ];
}

class MinesweeperElementTheme extends Equatable {
  final Color color;

  final IconData icon;

  const MinesweeperElementTheme({required this.color, required this.icon});

  MinesweeperElementTheme copyWith({Color? color, IconData? icon}) {
    return MinesweeperElementTheme(
        color: color ?? this.color, icon: icon ?? this.icon);
  }

  @override
  List<Object?> get props => [color, icon];
}

enum TileAnimation { normal, test }
