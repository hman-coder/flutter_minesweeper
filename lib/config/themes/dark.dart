import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/constants/colors.dart';
import 'package:minesweeper_flutter/constants/text.dart';
import 'shared.dart';

final ThemeData darkThemeData = ThemeData(
  fontFamily: kffFontFamily,
  textTheme: kttMainTextTheme.apply(
      bodyColor: kcForegroundDarkWhite, fontFamily: kffFontFamily),
  scaffoldBackgroundColor: kcBackgroundDarkColor,
  textButtonTheme: _kbtTextButtonDarkTheme,
  outlinedButtonTheme: _kbtOutlinedButtonDarkTheme,
  appBarTheme: _kabtAppBarDarkTheme,
  iconTheme: _kitIconDarkTheme,
  cardTheme: _kctCardDarkTheme,
  textSelectionTheme: _ktstTextSelectionTheme,
  inputDecorationTheme: _kidtInputDecorationTheme,
);

final TextSelectionThemeData _ktstTextSelectionTheme = TextSelectionThemeData(
  cursorColor: kcForegroundDarkBlue,
  selectionColor: kcForegroundDarkBlue,
  selectionHandleColor: kcForegroundDarkBlue,
);

final InputDecorationTheme _kidtInputDecorationTheme = InputDecorationTheme(
  fillColor: kcForegroundDarkWhite.withOpacity(0.2),
  focusColor: kcForegroundDarkWhite,
  filled: true,
  contentPadding: EdgeInsets.zero,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kcForegroundDarkBlue),
    borderRadius: BorderRadius.circular(20),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kcForegroundDarkWhite),
    borderRadius: BorderRadius.circular(20),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kcForegroundDarkWhite.withOpacity(0.4)),
    borderRadius: BorderRadius.circular(20),
  ),
);

final CardTheme _kctCardDarkTheme = CardTheme(
  color: kcCardDarkWhite,
  elevation: 8,
  margin: EdgeInsets.all(15),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

final AppBarTheme _kabtAppBarDarkTheme = AppBarTheme(
  backgroundColor: kcTransparentColor,
  centerTitle: true,
  backwardsCompatibility: false,
  titleTextStyle: headline6.copyWith(
      color: kcForegroundDarkWhite, fontFamily: kffFontFamily),
  iconTheme: IconThemeData(color: kcForegroundDarkWhite),
  actionsIconTheme: IconThemeData(color: kcForegroundDarkWhite),
  elevation: 0,
);

final IconThemeData _kitIconDarkTheme = IconThemeData(
  color: kcForegroundDarkWhite,
);

final TextButtonThemeData _kbtTextButtonDarkTheme = TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(kcForegroundDarkWhite),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(
        horizontal: 20,
      ),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
);

final OutlinedButtonThemeData _kbtOutlinedButtonDarkTheme =
    OutlinedButtonThemeData(
  style: ButtonStyle(
    side: MaterialStateProperty.all(
        BorderSide(color: kcForegroundDarkWhite, width: 1)),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 8,
      ),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(kcTransparentColor),
    foregroundColor: MaterialStateProperty.all(kcForegroundDarkBlue),
  ),
);
