import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';

import 'minesweeper_theme_event.dart';
import 'minesweeper_theme_state.dart';

class MinesweeperThemeBloc extends Bloc<MinesweeperThemeEvent, MinesweeperThemeState> {
  final MinesweeperThemeRepository _repository;

  MinesweeperThemeBloc(this._repository) : super(LoadingState());

  @override
  Stream<MinesweeperThemeState> mapEventToState(MinesweeperThemeEvent event) async* {
    if(event is ReloadThemeEvent) yield* _handleReloadThemeEvent();

  }

  Stream<MinesweeperThemeState> _handleReloadThemeEvent() async* {
    yield LoadingState();
    MinesweeperTheme? newConfig = await _repository.fetchTheme();
    yield ThemeUpdatedState(newConfig!);
  }
  
}