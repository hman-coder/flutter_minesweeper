import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';

const List<Color> defaultMineColors = [Colors.black, Colors.indigo];

const List<Color> premiumMineColors = [];

const List<IconData> defaultMineIcons = [MinesweeperIcons.mine, MinesweeperIcons.mine_relaxed];

const List<IconData> premiumMineIcons = [];

const List<Color> defaultFlagColors = [Colors.amber, Colors.green];

const List<Color> premiumFlagColors = [];

const List<IconData> defaultFlagIcons = [MinesweeperIcons.flag];

const List<IconData> premiumFlagIcons = [];

const List<Color> defaultTileColors = [Colors.black];

const List<Color> premiumTileColors = [];

const List<IconData> defaultTileIcons = [MinesweeperIcons.tile];

const List<IconData> premiumTileIcons = [];

const List<Color> defaultBackgroundColors = [Colors.white];

const List<Color> premiumBackgroundColors = [];

class UnlockableFeatures {
  final List<Color> flagColors;

  final List<Color> mineColors;

  final List<Color> tileColors;

  final List<Color> backgroundColors;

  final List<IconData> mineIcons;

  final List<IconData> flagIcons;

  final List<IconData> tileIcons;

  UnlockableFeatures.premium()
      : this.flagColors = defaultFlagColors..addAll(premiumFlagColors),
        this.mineColors = defaultMineColors..addAll(premiumMineColors),
        this.tileColors = defaultTileColors..addAll(premiumTileColors),
        this.backgroundColors = defaultBackgroundColors..addAll(premiumBackgroundColors),
        this.mineIcons = defaultMineIcons..addAll(premiumMineIcons),
        this.flagIcons = defaultFlagIcons..addAll(premiumFlagIcons),
        this.tileIcons = defaultTileIcons..addAll(premiumTileIcons);

  const UnlockableFeatures.none()
      : this.flagColors = defaultFlagColors,
        this.mineColors = defaultMineColors,
        this.tileColors = defaultTileColors,
        this.backgroundColors = defaultBackgroundColors,
        this.mineIcons = defaultMineIcons,
        this.flagIcons = defaultFlagIcons,
        this.tileIcons = defaultTileIcons;
}
