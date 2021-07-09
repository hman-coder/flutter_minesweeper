import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'themes/dark.dart';
import 'themes/light.dart';
import 'package:minesweeper_flutter/constants/colors.dart';
import 'package:flutter/material.dart';

export 'themes/neumorphic_dark.dart';
export 'themes/neumorphic_dark.dart';

ThemeData themeOfBackgroundColor(Color color) {
  ThemeData returnedTheme;
  if (color.isDarkThemeColor)
    returnedTheme = darkThemeData;
  else  returnedTheme = lightThemeData;
  return returnedTheme.copyWith(scaffoldBackgroundColor: color);
}

extension IsDarkThemeColor on Color {
  bool get isDarkThemeColor {
    return darkBackgroundColors.contains(this);
  }
}