import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/constants/text.dart';

const TextTheme kttMainTextTheme = TextTheme(
  headline5: headline5,
  headline6: headline6,
  bodyText2: bodyText2,
);

final AppBarTheme kabtAppBarTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  centerTitle: true,
  backwardsCompatibility: false,
  titleTextStyle: headline6.copyWith(color: Colors.black, fontFamily: kffFontFamily),
  iconTheme: IconThemeData(color: Colors.black),
  elevation: 0,
);
