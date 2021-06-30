import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/constants/colors.dart';

const List<IconData> defaultMineIcons = [
  MinesweeperIcons.mine,
  MinesweeperIcons.mine_relaxed
];

const List<IconData> premiumMineIcons = [];

const List<IconData> defaultFlagIcons = [MinesweeperIcons.flag];

const List<IconData> premiumFlagIcons = [];

const List<IconData> defaultTileIcons = [MinesweeperIcons.tile];

const List<IconData> premiumTileIcons = [];

const List<Color> defaultLightElementColors = [
  kcElementLightAmber,
  kcElementLightBlack,
  kcElementLightBlackOlive,
  kcElementLightCadetBlue,
  kcElementLightDarkMossGreen,
  kcElementLightEggplant,
  kcElementLightPersianOrange,
];

const List<Color> defaultDarkElementColors = [
  kcElementDarkCameoPink,
  kcElementDarkMiddleBlue,
  kcElementDarkThistle,
  kcElementDarkWhite,
  kcElementDarkWildBlueYonder,
];

const List<Color> defaultBackgroundColors = [
  kcBackgroundWhiteColor,
  kcBackgroundDarkColor
];

const List<Color> premiumBackgroundColors = [];

class UnlockableFeatures {
  final List<Color> flagColors;

  final List<Color> mineColors;

  final List<Color> tileColors;

  final List<Color> backgroundColors;

  final List<IconData> mineIcons;

  final List<IconData> flagIcons;

  final List<IconData> tileIcons;

  const UnlockableFeatures.light()
      : this.flagColors = defaultLightElementColors,
        this.mineColors = defaultLightElementColors,
        this.tileColors = defaultLightElementColors,
        this.backgroundColors = defaultBackgroundColors,
        this.mineIcons = defaultMineIcons,
        this.flagIcons = defaultFlagIcons,
        this.tileIcons = defaultTileIcons;

  const UnlockableFeatures.dark()
      : this.flagColors = defaultDarkElementColors,
        this.mineColors = defaultDarkElementColors,
        this.tileColors = defaultDarkElementColors,
        this.backgroundColors = defaultBackgroundColors,
        this.mineIcons = defaultMineIcons,
        this.flagIcons = defaultFlagIcons,
        this.tileIcons = defaultTileIcons;
}
