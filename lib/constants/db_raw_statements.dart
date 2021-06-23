const String ksMinesweeperThemeTableCreateStatement = '''
CREATE TABLE "minesweeper_theme" (
	"mine_icon"	TEXT,
	"flag_icon"	TEXT,
	"tile_icon"	TEXT,
	"mine_color"	NUMERIC,
	"flag_color"	NUMERIC,
	"tile_color"	NUMERIC,
	"background_color"	NUMERIC,
	"animation"	TEXT
)
''';

const String ksMinesweeperLevelSettingsTableCreateStatement = '''
CREATE TABLE "minesweeper_level_settings" (
  "height"	INTEGER,
  "width"	INTEGER,
  "mines"	INTEGER,
  "diffculty"	INTEGER,
  "mode"	INTEGER
);
''';

const String ksGameSettingsTableCreateStatement = '''
  CREATE TABLE "game_settings" (
  "music"	INTEGER,
  "sfx"	INTEGER,
  "notifications"	INTEGER
);
''';

const String ksGameSettingsInitialDataInsertStatement = '''
INSERT INTO "game_settings" VALUES (1, 1, 1)
''';

const String ksMinesweeperThemeInitialDataInsertStatement = '''
INSERT INTO "minesweeper_theme" VALUES ("mine", "flag", "tile", 0xFF000000, 0xFFFFC107, 0xFFFFFFFF, 0xFFFFFFFF, "animation",)
''';

String Function(int oldVersion, int newVersion) getUpdateStatement =
    (oldV, newV) {
  return "";
};
