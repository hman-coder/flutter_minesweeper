import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme_bloc.dart';

class FlagIcon extends StatelessWidget {
  final double? size;

  final Color? color;

  /// The flag icon is not centered by default. This is a little
  /// adjustment handle to help center the flag. Default value is 2.
  final double xOffset;

  const FlagIcon({
    Key? key,
    this.size,
    this.xOffset = 2,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset:  Offset(xOffset, 0),
      child: Icon(
        context.watch<MinesweeperThemeBloc>().state.flagIcon,
        size: size,
        color: this.color ?? context.watch<MinesweeperThemeBloc>().state.flagColor,
      ),
    );
  }
}
