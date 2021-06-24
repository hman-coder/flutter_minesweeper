import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme_bloc.dart';

class MineIcon extends StatelessWidget {
  final double? size;

  final Color? color;

  const MineIcon({
    Key? key,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      context.watch<MinesweeperThemeBloc>().state.mineIcon,
      size: size,
      color: color ?? context.watch<MinesweeperThemeBloc>().state.mineColor,
    );
  }
}
