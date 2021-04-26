class MinesweeperThemeEntity {
  final int tileBackgroundColorValue;

  final String flagIconPath;

  final String mineIconPath;

  final String tileShape;

  final String animation;

  final int foregroundColorValue;

  MinesweeperThemeEntity({
    required this.foregroundColorValue,
    required this.tileBackgroundColorValue,
    required this.flagIconPath,
    this.animation = '',
    required this.mineIconPath,
    required this.tileShape,
  });

  MinesweeperThemeEntity.fromMap(Map<String, dynamic> map) :
    this.foregroundColorValue = map["foreground_color"],
    this.animation = map['animation'] ?? '',
    this.tileBackgroundColorValue = map["background_color"],
    this.flagIconPath = map["flag_icon"],
    this.mineIconPath = map["mine_icon"],
    this.tileShape = map["tile_shape"]
  ;
}
