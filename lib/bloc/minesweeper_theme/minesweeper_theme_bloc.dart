import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme/minesweeper_theme_event.dart';
import 'package:minesweeper_flutter/entities/minesweeper_theme_entity.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';
import 'package:minesweeper_flutter/services/transformers.dart';
import 'minesweeper_theme_state.dart';
import 'package:minesweeper_flutter/services/transformers/entity_transformer.dart';

/// Transforms the given [MinesweeperTheme] object into an entity and then tries to update it using the [MinesweeperThemeRepository].
Future<bool> _transformThemeAndUpdate(
    MinesweeperThemeRepository repository, MinesweeperTheme theme) {
  var entity = transformModel(theme) as MinesweeperThemeEntity;
  return repository.update(entity);
}

class MinesweeperThemeBloc
    extends Bloc<MinesweeperThemeEvent, MinesweeperThemeState> {

  final MinesweeperThemeRepository _repository;

  MinesweeperTheme currentTheme;

  bool initialized = false;

  MinesweeperThemeBloc(
    this._repository,
  )   : currentTheme = MinesweeperTheme.initial(),
        super(InitialState());

  @override
  Stream<MinesweeperThemeState> mapEventToState(
      MinesweeperThemeEvent event) async* {
    if (event is ReloadEvent) yield* _handleReload(event);
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

  Stream<MinesweeperThemeState> _handleReload(ReloadEvent event) async* {
    var result = await _repository.fetchTheme();
    currentTheme = transformEntity(result);
    yield ThemeReloadedState(currentTheme);
    initialized = true;
  }

  Stream<MinesweeperThemeState> _handleBackgroundChange(
      BackgroundColorChangeEvent event) async* {
    var newTheme = currentTheme.copyWith(backgroundColor: event.color);
    var newThemeEntity = transformModel(newTheme) as MinesweeperThemeEntity;
    var success = await _repository.update(newThemeEntity);

    if (success) {
      currentTheme = newTheme;
      yield BackgroundColorUpdatedState(event.color);
    } else {
      yield ErrorState("Error updating background color.");
    }
  }

  Stream<MinesweeperThemeState> _handleFlagThemeChange(
      FlagThemeChangeEvent event) async* {
    var newFlagTheme =
        currentTheme.flagTheme.copyWith(color: event.color, icon: event.icon);
    var newTheme = currentTheme.copyWith(flagTheme: newFlagTheme);
    var success = await _transformThemeAndUpdate(_repository, newTheme);

    if (success) {
      currentTheme = newTheme;
      yield FlagThemeUpdatedState(newFlagTheme);
    } else {
      yield ErrorState("Error updating flag theme.");
    }
  }

  Stream<MinesweeperThemeState> _handleMineThemeChange(
      MineThemeChangeEvent event) async* {
    var newMineTheme =
        currentTheme.mineTheme.copyWith(color: event.color, icon: event.icon);
    var newTheme = currentTheme.copyWith(mineTheme: newMineTheme);
    var success = await _transformThemeAndUpdate(_repository, newTheme);

    if (success) {
      currentTheme = newTheme;
      yield MineThemeUpdatedState(newMineTheme);
    } else {
      yield ErrorState("Error updating mine theme.");
    }
  }

  Stream<MinesweeperThemeState> _handleTileThemeChange(
      TileThemeChangeEvent event) async* {
    var newTileTheme =
        currentTheme.tileTheme.copyWith(color: event.color, icon: event.icon);
    var newTheme = currentTheme.copyWith(tileTheme: newTileTheme);
    var success = await _transformThemeAndUpdate(_repository, newTheme);

    if (success) {
      currentTheme = newTheme;
      yield TileThemeUpdatedState(newTileTheme);
    } else {
      yield ErrorState("Error updating tile theme.");
    }
  }

  Stream<MinesweeperThemeState> _handleTileAnimationChange(
      TileAnimationChangeEvent event) async* {
    var newTheme = currentTheme.copyWith(tileAnimation: event.animation);
    var success = await _transformThemeAndUpdate(_repository, newTheme);

    if (success) {
      currentTheme = newTheme;
      yield TileAnimationUpdatedState(event.animation);
    } else {
      yield ErrorState("Error updating tile animation.");
    }
  }
}
