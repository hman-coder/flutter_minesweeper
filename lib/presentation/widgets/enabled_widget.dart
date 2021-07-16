import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/game_theme/game_theme_bloc.dart';

class EnabledWidget extends StatelessWidget {
  final Widget child;

  final bool enabled;

  const EnabledWidget({
    required this.child,
    required this.enabled,
    Key? key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(enabled) return child;
    var color = context.read<GameThemeBloc>().currentTheme.isDarkTheme
        ? Colors.grey
        : Colors.white.withOpacity(0.5);
    return IgnorePointer(
      child: ColorFiltered(
          colorFilter: ColorFilter.mode(color, BlendMode.modulate), child: child),
    );
  }
}
