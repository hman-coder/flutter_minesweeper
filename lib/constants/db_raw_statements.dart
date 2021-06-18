const String ksMinesweeperThemeTableCreateStatement = '''
CREATE TABLE "minesweeper_theme" (
"background_color"	TEXT,
"foreground_color" TEXT,
"mine_icon"	TEXT,
"flag_icon"	TEXT,
"animation" TEXT,
"tile_shape"	TEXT);
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


String Function(int oldVersion, int newVersion) getUpdateStatement = (oldV, newV)  {
  return "";
};