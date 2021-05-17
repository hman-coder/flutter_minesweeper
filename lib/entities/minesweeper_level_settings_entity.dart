class MinesweeperLevelSettingsEntity {
  final int mines;

  final int height;

  final int width;

  MinesweeperLevelSettingsEntity({
    required this.mines,
    required this.height,
    required this.width,
  });


  MinesweeperLevelSettingsEntity.fromMap(Map<String, dynamic> map) :
    this.mines = map['mines'],
    this.height = map['height'],
    this.width = map['width']
  ;
}