import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/game_theme/game_theme_bloc.dart';

/// A button that expands infinitely to fill its parent
/// Its background color is the same as the color of Mines found in
/// ancestor [MinesweeperThemeBloc].
class FillSizeButton extends StatelessWidget {
  final VoidCallback onPressed;

  final Widget child;

  const FillSizeButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: MaterialButton(
        color: context.watch<GameThemeBloc>().currentTheme.mineTheme.color,
        onPressed: this.onPressed,
        child: Center(child: child),
      ),
    );
  }
}
