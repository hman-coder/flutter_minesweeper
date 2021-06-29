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
      buildWhen: _blocRebuildCondition,
      builder: (context, state) {
        var mineTheme = context.read<MinesweeperThemeBloc>().currentTheme.mineTheme;
        return Icon(
        mineTheme.icon,
        size: size,
        color: (color ?? mineTheme.color).withOpacity(opacity),
      );
      }
    );
  }

  bool _blocRebuildCondition(previous, current) {
    return current is MineThemeUpdatedState || current is InitialState || current is ThemeReloadedState;
  }
}
