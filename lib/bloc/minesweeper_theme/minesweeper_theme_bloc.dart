import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme/minesweeper_theme_event.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';

import 'minesweeper_theme_state.dart';

class MinesweeperThemeBloc
    extends Bloc<MinesweeperThemeEvent, MinesweeperThemeState> {
  final MinesweeperThemeRepository _repository;

  final MinesweeperTheme? currentTheme = null;

  MinesweeperThemeBloc(this._repository) : super(InitialState()) {
    add(ReloadEvent());
  }

  @override
  Stream<MinesweeperThemeState> mapEventToState(
      MinesweeperThemeEvent event) async* {
    if (event is BackgroundColorChangeEvent)
      yield* _handleBackgroundChange(event);
    else if (event is FlagThemeChangeEvent)
      yield* _handleFlagThemeChange(event);
    else if (event is MineThemeChangeEvent)
      yield* _handleMineThemeChange(event);
    else if (event is TileThemeChangeEvent)
      yield* _handleTileThemeChange(event);
    else if (event is TileAnimationChangeEvent)
      yield* _handleTileAnimationChange(event);
  }

  Stream<MinesweeperThemeState> _handleBackgroundChange(
      BackgroundColorChangeEvent event) async* {
    yield BackgroundColorChangeState(event.color);
  }

  Stream<MinesweeperThemeState> _handleFlagThemeChange(
      FlagThemeChangeEvent event) async* {
    yield FlagThemeChangedState(
      MinesweeperElementTheme(
        color: event.color!,
        icon: event.icon!,
      ),
    );
  }

  Stream<MinesweeperThemeState> _handleMineThemeChange(
      MineThemeChangeEvent event) async* {
    yield MineThemeChangedState(
      MinesweeperElementTheme(
        color: event.color!,
        icon: event.icon!,
      ),
    );
  }

  Stream<MinesweeperThemeState> _handleTileThemeChange(
      TileThemeChangeEvent event) async* {
    yield TileThemeChangedState(
      MinesweeperElementTheme(
        color: event.color!,
        icon: event.icon!,
      ),
    );
  }

  Stream<MinesweeperThemeState> _handleTileAnimationChange(
      TileAnimationChangeEvent event) async* {}
}
