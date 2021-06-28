import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const kFontFam = 'Minesweeper';

const kcpMineCodePoint = 0xe800;
const kcpFlagCodePoint = 0xe801;
const kcpMineRelaxedCodePoint = 0xe802;

class MinesweeperIcons {
  MinesweeperIcons._();

  static const String? _kFontPkg = null;

  static const IconData mine = IconData(kcpMineCodePoint,
      fontFamily: kFontFam, fontPackage: _kFontPkg);
  static const IconData flag = IconData(kcpFlagCodePoint,
      fontFamily: kFontFam, fontPackage: _kFontPkg);
  static const IconData mine_relaxed = IconData(kcpMineRelaxedCodePoint,
      fontFamily: kFontFam, fontPackage: _kFontPkg);
  static const IconData tile = Icons.circle;
}