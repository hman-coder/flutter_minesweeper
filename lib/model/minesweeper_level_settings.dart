const String kkMinesKey = 'mines';
const String kkHeightKey = 'height';
const String kkWidthKey = 'width';

class MinesweeperLevelSettings {
  final int height;

  final int width;

  final int mines;

  const MinesweeperLevelSettings.beginner({
    this.height = 10,
    this.width = 10,
    this.mines = 10,
  });

  const MinesweeperLevelSettings.intermediate({
    this.height = 16,
    this.width = 13,
    this.mines = 40,
  });

  const MinesweeperLevelSettings.expert({
    this.height = 30,
    this.width = 16,
    this.mines = 99,
  });

  const MinesweeperLevelSettings.custom({
    required this.height,
    required this.width,
    required this.mines,
  });

  MinesweeperLevelSettings.fromMap(Map<String, dynamic> map)
      : this.height = map[kkHeightKey],
        this.width = map[kkWidthKey],
        this.mines = map[kkMinesKey];

  MinesweeperLevelSettings copyWith({int? height, int? width, int? mines}) {
    return MinesweeperLevelSettings.custom(
      height: height ?? this.height,
      width: width ?? this.width,
      mines: mines ?? this.mines,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map[kkMinesKey] = this.mines;
    map[kkHeightKey] = this.height;
    map[kkWidthKey] = this.width;
    return map;
  }
}
