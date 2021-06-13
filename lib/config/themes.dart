import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/constants/text.dart';

const TextTheme kttMainTextTheme = TextTheme(
  headline5: headline5,
  headline6: headline6,
  bodyText2: bodyText2,
  button: button,
);

final AppBarTheme kabtAppBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  centerTitle: true,
  backwardsCompatibility: false,
  titleTextStyle:
      headline6.copyWith(color: Colors.black, fontFamily: kffFontFamily),
  iconTheme: IconThemeData(color: Colors.black),
  actionsIconTheme: IconThemeData(color: Colors.black),
  elevation: 0,
);

final OutlinedButtonThemeData kbtOutlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    side: MaterialStateProperty.all(BorderSide(color: Colors.blueGrey, width: 1)),
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
    backgroundColor: MaterialStateProperty.all(Colors.transparent),
    foregroundColor: MaterialStateProperty.all(Colors.blue),
  ),
);

final TextButtonThemeData kbtTextButtonTheme = TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.black)
  )
);
