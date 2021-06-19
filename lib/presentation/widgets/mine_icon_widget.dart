import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';

class MineIcon extends StatelessWidget {
  final double? size;

  final Color color;

  const MineIcon({
    Key? key,
    this.size,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      MinesweeperIcons.mine,
      size: size,
      color: color,
    );
  }
}
