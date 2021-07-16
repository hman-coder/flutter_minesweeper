import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/game_theme.dart';

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
      offset: Offset(xOffset, 0),
      child: BlocBuilder<GameThemeBloc, GameThemeState>(
        buildWhen: _blocRebuildCondition,
        builder: (context, state) {
          var flagTheme = context.read<GameThemeBloc>().currentTheme.flagTheme;
          return Icon(
            flagTheme.icon,
            size: size,
            color: this.color ?? flagTheme.color,
          );
        },
      ),
    );
  }

  bool _blocRebuildCondition(prev, cur) {
    return cur is FlagThemeUpdatedState || cur is InitialState || cur is ThemeReloadedState;
  }
}
