import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart';

class MineIcon extends StatelessWidget {
  final double? size;

  final Color? color;

  final double opacity;

  const MineIcon({
    Key? key,
    this.size,
    this.color,
    this.opacity = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MinesweeperThemeBloc, MinesweeperThemeState>(
      buildWhen: (previous, current) => current is MineThemeChangedState || current is InitialState,
      builder: (context, state) {
        var mineTheme;
        if(state is InitialState) mineTheme = state.theme.mineTheme;
        else if (state is MineThemeChangedState) mineTheme = state.mineTheme;
        return Icon(
        mineTheme.icon,
        size: size,
        color: (color ?? mineTheme.color).withOpacity(opacity),
      );
      }
    );
  }
}
