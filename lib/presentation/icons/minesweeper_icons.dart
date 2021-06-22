/// Flutter icons Minesweeper
/// Copyright (C) 2021 by original authors @ fluttericon.com, fontello.com
/// This font was generated by FlutterIcon.com, which is derived from Fontello.
///
/// To use this font, place it in your fonts/ directory and include the
/// following in your pubspec.yaml
///
/// flutter:
///   fonts:
///    - family:  Minesweeper
///      fonts:
///       - asset: fonts/Minesweeper.ttf
///
/// 
///
import 'package:flutter/widgets.dart';

const _kFontFam = 'Minesweeper';

const _kcpMineCodePoint = 0xe800;
const _kcpFlagCodePoint = 0xe801;
const _kcpMineRelaxedCodePoint = 0xe802;

class MinesweeperIcons {
  MinesweeperIcons._();

  static const String? _kFontPkg = null;

  static const IconData mine = IconData(_kcpMineCodePoint, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData flag = IconData(_kcpFlagCodePoint, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData mine_relaxed = IconData(_kcpMineRelaxedCodePoint, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}


extension MinesweeperIconToString on IconData {
  String toAppString() {
    if(this.fontFamily == _kFontFam) {
      switch(this.codePoint) {
        case _kcpMineCodePoint:
          return "mine";

        case _kcpMineRelaxedCodePoint:
          return "relaxed";

        case _kcpFlagCodePoint:
          return "flag";
      }
    }

    throw Exception("This icon data is not of MinesweeperIcons.");
  }
}