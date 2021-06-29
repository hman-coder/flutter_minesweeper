import 'themes/dark.dart';
import 'themes/light.dart';
import 'package:minesweeper_flutter/constants/colors.dart';
import 'package:flutter/material.dart';

ThemeData themeOfBackgroundColor(Color color) {
  ThemeData returnedTheme;
  if (darkBackgroundColors.contains(color))
    returnedTheme = darkThemeData;
  else  returnedTheme = lightThemeData;
  return returnedTheme.copyWith(scaffoldBackgroundColor: color);
}