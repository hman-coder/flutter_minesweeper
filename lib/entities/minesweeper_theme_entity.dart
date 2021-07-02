import 'package:equatable/equatable.dart';
import 'package:minesweeper_flutter/constants/db_keys.dart';

class MinesweeperThemeEntity extends Equatable {
  final int backgroundColorValue;

  final String tileAnimation;

  final int mineColorValue;

  final int flagColorValue;

  final int tileColorValue;

  final String mineIcon;

  final String flagIcon;

  final String tileIcon;

  MinesweeperThemeEntity({
    required this.backgroundColorValue,
    required this.tileAnimation,
    required this.mineColorValue,
    required this.flagColorValue,
    required this.tileColorValue,
    required this.mineIcon,
    required this.flagIcon,
    required this.tileIcon,
  });

  MinesweeperThemeEntity.fromMap(Map<String, dynamic> map)
      : this.backgroundColorValue = map[kkBackgroundColorKey],
        this.tileAnimation = map[kkAnimationKey],
        this.mineColorValue = map[kkMineColorKey],
        this.flagColorValue = map[kkFlagColorKey],
        this.tileColorValue = map[kkTileColorKey],
        this.mineIcon = map[kkMineIconKey],
        this.flagIcon = map[kkFlagIconKey],
        this.tileIcon = map[kkTileIconKey];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map[kkBackgroundColorKey] = backgroundColorValue;
    map[kkAnimationKey] = tileAnimation;
    map[kkMineColorKey] = mineColorValue;
    map[kkMineIconKey] = mineIcon;
    map[kkFlagColorKey] = flagColorValue;
    map[kkFlagIconKey] = flagIcon;
    map[kkTileColorKey] = tileColorValue;
    map[kkTileIconKey] = tileIcon;
    return map;
  } 

  @override
  List<Object?> get props => [backgroundColorValue, tileAnimation, mineColorValue, flagColorValue, tileColorValue, mineIcon, flagIcon, tileIcon];
}
