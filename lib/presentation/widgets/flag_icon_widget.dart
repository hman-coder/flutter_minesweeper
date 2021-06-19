import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';

class FlagIcon extends StatelessWidget {
  final double? size;

  final Color color;

  /// The flag icon is not centered by default. This is a little
  /// adjustment handle to help center the flag. Default value is 2.
  final double xOffset;

  const FlagIcon({
    Key? key,
    this.size,
    this.xOffset = 2,
    this.color = Colors.amber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset:  Offset(xOffset, 0),
      child: Icon(
        MinesweeperIcons.flag,
        size: size,
        color: color,
      ),
    );
  }
}
