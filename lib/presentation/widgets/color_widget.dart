import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/constants/colors.dart';

/// A widget that showcases a color.
class ColorWidget extends StatelessWidget {
  final Color color;

  final double size;

  const ColorWidget(this.color, {this.size = 50, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: kcBlueGreyColor)
      ),
    );
  }
}