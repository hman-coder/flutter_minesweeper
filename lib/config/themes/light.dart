import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/constants/colors.dart';
import 'package:minesweeper_flutter/constants/text.dart';
import 'shared.dart';

final ThemeData lightThemeData = ThemeData(
  fontFamily: kffFontFamily,
  textTheme: kttMainTextTheme.apply(fontFamily: kffFontFamily),
  textButtonTheme: kbtTextButtonTheme,
  outlinedButtonTheme: kbtOutlinedButtonLightTheme,
  appBarTheme: kabtAppBarLightTheme,
  iconTheme: kitIconLightTheme,
  cardTheme: kctCardLightTheme,
);

final CardTheme kctCardLightTheme = CardTheme(
    margin: EdgeInsets.all(15),
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

final AppBarTheme kabtAppBarLightTheme = AppBarTheme(
  backgroundColor: kcTransparentColor,
  centerTitle: true,
  backwardsCompatibility: false,
  titleTextStyle: headline6.copyWith(
      color: kcForegroundLightBlack, fontFamily: kffFontFamily),
  iconTheme: IconThemeData(color: kcForegroundLightBlack),
  actionsIconTheme: IconThemeData(color: kcForegroundLightBlack),
  elevation: 0,
);

final IconThemeData kitIconLightTheme = IconThemeData(
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

final OutlinedButtonThemeData kbtOutlinedButtonLightTheme =
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
