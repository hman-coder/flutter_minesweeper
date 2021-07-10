import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:minesweeper_flutter/constants/colors.dart';

const NeumorphicThemeData kntdDarkNeumorphicTheme = NeumorphicThemeData(
  depth: 3,
  intensity: 1,
  baseColor: kcDarkModeNeumorphicBackground,
  shadowDarkColorEmboss: kcDarkModeNeumorphicEmboss,
  shadowLightColor: kcDarkModeNeumorphicShadowColor,
  borderColor: kcDarkModeNeumorphicBorderColor, 
  borderWidth: 1,
  boxShape: NeumorphicBoxShape.circle(),
);