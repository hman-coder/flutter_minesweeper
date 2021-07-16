import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/entities/game_theme_entity.dart';
import 'package:minesweeper_flutter/model/game_theme.dart';
import 'package:minesweeper_flutter/repository/game_theme_repository.dart';
import 'package:minesweeper_flutter/services/transformers.dart';
import 'package:minesweeper_flutter/services/transformers/entity_transformer.dart';

import 'game_theme_event.dart';
import 'game_theme_state.dart';

/// Transforms the given [MinesweeperTheme] object into an entity and then tries to update it using the [GameThemeRepository].
Future<bool> _transformThemeAndUpdate(
    GameThemeRepository repository, MinesweeperTheme theme) {
  var entity = transformModel(theme) as GameThemeEntity;
  return repository.update(entity);
}

class GameThemeBloc extends Bloc<GameThemeEvent, GameThemeState> {
  final GameThemeRepository _repository;

  MinesweeperTheme currentTheme;

  bool initialized = false;

  GameThemeBloc(
    this._repository,
  )   : currentTheme = MinesweeperTheme.initial(),
        super(InitialState());

  @override
  Stream<GameThemeState> mapEventToState(GameThemeEvent event) async* {
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

  Stream<GameThemeState> _handleReload(ReloadEvent event) async* {
    var result = await _repository.fetchTheme();
    currentTheme = transformEntity(result);
    yield ThemeReloadedState(currentTheme);
    initialized = true;
  }

  Stream<GameThemeState> _handleBackgroundChange(
      BackgroundColorChangeEvent event) async* {
    var newTheme = currentTheme.copyWith(backgroundColor: event.color);
    var newThemeEntity = transformModel(newTheme) as GameThemeEntity;
    var success = await _repository.update(newThemeEntity);

    if (success) {
      currentTheme = newTheme;
      yield BackgroundColorUpdatedState(event.color);
    } else {
      yield ErrorState("Error updating background color.");
    }
  }

  Stream<GameThemeState> _handleFlagThemeChange(
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

  Stream<GameThemeState> _handleMineThemeChange(
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

  Stream<GameThemeState> _handleTileThemeChange(
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

  Stream<GameThemeState> _handleTileAnimationChange(
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
