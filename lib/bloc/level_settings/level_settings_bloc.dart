import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/entities/level_settings_entity.dart';
import 'package:minesweeper_flutter/model/level_settings.dart';
import 'package:minesweeper_flutter/repository/level_settings_repository.dart';
import 'package:minesweeper_flutter/services/transformers/entity_transformer.dart';
import 'package:minesweeper_flutter/services/transformers/model_transformer.dart';

import 'level_settings_event.dart';
import 'level_settings_state.dart';

Future<bool> transformModelAndUpdate(
    LevelSettings model, LevelSettingsRepository repository) async {
  var entity = transformModel<LevelSettingsEntity>(model);
  return await repository.updateSettings(entity);
}

class LevelSettingsBloc extends Bloc<LevelSettingsEvent, LevelSettingsState> {
  late final LevelSettingsRepository repository;

  LevelSettings currentSettings;

  LevelSettingsBloc({required this.repository})
      : currentSettings =
            LevelSettings.standardWithDifficulty(GameDifficulty.intermediate),
        super(InitialState()) {
    add(ReloadEvent());
  }

  @override
  Stream<LevelSettingsState> mapEventToState(LevelSettingsEvent event) async* {
    if (event is ReloadEvent)
      yield* _handleReloadEvent();
    else if (event is HeightChangedEvent)
      yield* _handleHeightChangedEvent(event);
    else if (event is WidthChangedEvent)
      yield* _handleWidthChangedEvent(event);
    else if (event is MinesChangedEvent)
      yield* _handleMinesChangedEvent(event);
    else if (event is DifficultyChangedEvent)
      yield* _handleDifficultyChangedEvent(event);
    else if (event is GameModeChangedEvent)
      yield* _handleModeChangedEvent(event);
  }

  Stream<LevelSettingsState> _handleReloadEvent() async* {
    yield LoadingState();
    var entity;

    entity = await repository.fetchSettings();
    var settings = transformEntity(entity);
    if (settings == null)
      settings = LevelSettings.standardWithDifficulty(GameDifficulty.beginner);
    currentSettings = settings;
    yield SettingsUpdatedState(settings);
  }

  Stream<LevelSettingsState> _handleHeightChangedEvent(
      HeightChangedEvent event) async* {
    yield LoadingState();
    var newSettings = currentSettings.copyWith(height: event.height);

    bool success = await transformModelAndUpdate(newSettings, this.repository);
    if (success) {
      yield HeightUpdatedState(event.height);
      this.currentSettings = newSettings;
    }
  }

  Stream<LevelSettingsState> _handleWidthChangedEvent(
      WidthChangedEvent event) async* {
    yield LoadingState();
    var newSettings = currentSettings.copyWith(width: event.width);

    bool success = await transformModelAndUpdate(newSettings, repository);
    if (success) {
      yield WidthUpdatedState(event.width);
      this.currentSettings = newSettings;
    }
  }

  Stream<LevelSettingsState> _handleMinesChangedEvent(
      MinesChangedEvent event) async* {
    yield LoadingState();
    var newSettings = currentSettings.copyWith(mines: event.mines);
    bool success = await transformModelAndUpdate(newSettings, repository);

    if (success) {
      yield MinesUpdatedState(event.mines);
      this.currentSettings = newSettings;
    }
  }

  Stream<LevelSettingsState> _handleDifficultyChangedEvent(
      DifficultyChangedEvent event) async* {
    yield LoadingState();
    var newSettings = currentSettings.copyWith(difficulty: event.difficulty);
    bool success = await transformModelAndUpdate(newSettings, repository);

    if (success) {
      yield DifficultyUpdatedState(event.difficulty);
      this.currentSettings = newSettings;
    }
  }

  Stream<LevelSettingsState> _handleModeChangedEvent(
      GameModeChangedEvent event) async* {
    yield LoadingState();
    var newSettings = currentSettings.copyWith(mode: event.mode);
    bool success = await transformModelAndUpdate(newSettings, repository);

    if (success) {
      yield GameModeUpdatedState(event.mode);
      this.currentSettings = newSettings;
    }
  }
}
