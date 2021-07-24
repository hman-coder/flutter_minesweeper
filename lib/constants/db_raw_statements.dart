import 'package:minesweeper_flutter/constants/db_keys.dart';

const String ksMinesweeperThemeTableCreateStatement = '''
CREATE TABLE "$kkMinesweeperThemeTableKey" (
	"$kkMineIconKey"	TEXT,
	"$kkFlagIconKey"	TEXT,
	"$kkTileIconKey"	TEXT,
	"$kkMineColorKey"	NUMERIC,
	"$kkFlagColorKey"	NUMERIC,
	"$kkTileColorKey"	NUMERIC,
	"$kkBackgroundColorKey"	NUMERIC,
	"$kkAnimationKey"	TEXT
)
''';

const String ksLevelSettingsTableCreateStatement = '''
CREATE TABLE "$kkLevelSettingsTableKey" (
  "$kkHeight"	INTEGER,
  "$kkWidth"	INTEGER,
  "$kkMines"	INTEGER,
  "$kkGameDifficulty"	TEXT,
  "$kkGameMode"	TEXT
);
''';

const String ksGameSettingsTableCreateStatement = '''
  CREATE TABLE "$kkGameSettingsTableName" (
  "$kkGameSettingsMusic"	INTEGER,
  "$kkGameSettingsSFX"	INTEGER,
  "$kkGameSettingsNotifications"	INTEGER
);
''';

const String ksGameSettingsInitialDataInsertStatement = '''
INSERT INTO "$kkGameSettingsTableName" VALUES (1, 1, 1)
''';

const String ksMinesweeperThemeInitialDataInsertStatement = '''
INSERT INTO "$kkMinesweeperThemeTableKey" VALUES ("mine", "flag", "tile", 0xFF000000, 0xFFFFC107, 0xFFFFC107, 0xFFFFFFFF, "normal")
''';

const String ksLevelSettingsInitialDataInsertStatement = '''
INSERT INTO "$kkLevelSettingsTableKey" VALUES (10,10,10,"easy","standard")
''';

String Function(int oldVersion, int newVersion) getUpdateStatement =
    (oldV, newV) {
  return "";
};
