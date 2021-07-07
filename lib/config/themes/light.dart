import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/constants/colors.dart';
import 'package:minesweeper_flutter/constants/text.dart';
import 'shared.dart';

final ThemeData lightThemeData = ThemeData(
  fontFamily: kffFontFamily,
  textTheme: kttMainTextTheme.apply(fontFamily: kffFontFamily),
  textButtonTheme: kbtTextButtonTheme,
  outlinedButtonTheme: _kbtOutlinedButtonLightTheme,
  appBarTheme: _kabtAppBarLightTheme,
  iconTheme: _kitIconLightTheme,
  cardTheme: _kctCardLightTheme,
  textSelectionTheme: _ktstTextSelectionTheme,
  inputDecorationTheme: _kidtInputDecorationTheme,
);

final TextSelectionThemeData _ktstTextSelectionTheme = TextSelectionThemeData(
  cursorColor: kcForegroundDarkBlue,
  selectionColor: kcForegroundDarkBlue,
  selectionHandleColor: kcForegroundDarkBlue,
);

final InputDecorationTheme _kidtInputDecorationTheme = InputDecorationTheme(
  fillColor: kcForegroundLightGrey,
  focusColor: kcForegroundLightBlue,
  filled: true,
  contentPadding: EdgeInsets.zero,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kcForegroundLightBlue),
    borderRadius: BorderRadius.circular(20),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kcForegroundLightBlack),
    borderRadius: BorderRadius.circular(20),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kcForegroundLightBlack),
    borderRadius: BorderRadius.circular(20),
  ),
);

final CardTheme _kctCardLightTheme = CardTheme(
    margin: EdgeInsets.all(15),
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

final AppBarTheme _kabtAppBarLightTheme = AppBarTheme(
  backgroundColor: kcTransparentColor,
  centerTitle: true,
  backwardsCompatibility: false,
  titleTextStyle: headline6.copyWith(
      color: kcForegroundLightBlack, fontFamily: kffFontFamily),
  iconTheme: IconThemeData(color: kcForegroundLightBlack),
  actionsIconTheme: IconThemeData(color: kcForegroundLightBlack),
  elevation: 0,
);

final IconThemeData _kitIconLightTheme = IconThemeData(
  color: kcForegroundLightBlack,
);

final TextButtonThemeData kbtTextButtonLightTheme = TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(kcForegroundLightBlack),
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

final OutlinedButtonThemeData _kbtOutlinedButtonLightTheme =
    OutlinedButtonThemeData(
  style: ButtonStyle(
    side:
        MaterialStateProperty.all(BorderSide(color: kcBlueGreyColor, width: 1)),
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
    foregroundColor: MaterialStateProperty.all(kcForegroundLightBlue),
  ),
);
