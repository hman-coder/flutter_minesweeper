import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/game_settings/game_settings_event.dart';
import 'package:minesweeper_flutter/bloc/game_settings/game_settings_state.dart';
import 'package:minesweeper_flutter/entities/game_settings_entity.dart';
import 'package:minesweeper_flutter/model/game_settings.dart';
import 'package:minesweeper_flutter/repository/game_settings_repository.dart';
import 'package:minesweeper_flutter/services/transformers/entity_transformer.dart';
import 'package:minesweeper_flutter/services/transformers/model_transformer.dart';

/// Transforms the given [GameSettings] object into an entity and then tries to update it using the [GameSettingsRepository].
Future<bool> _transformThemeAndUpdate(
    GameSettingsRepository repository, GameSettings settings) {
  var entity = transformModel(settings) as GameSettingsEntity;
  return repository.update(entity);
}

class GameSettingsBloc extends Bloc<GameSettingsEvent, GameSettingsState> {
  final GameSettingsRepository repository;

  bool _initialized = false;

  bool get initialized => _initialized;

  GameSettings _currentSettings = GameSettings();

  GameSettings get settings => _currentSettings;

  GameSettingsBloc(this.repository)
      : super(InitialState()) {
    _init();
  }

  void _init() {
    add(ReloadEvent());
  }

  @override
  Stream<GameSettingsState> mapEventToState(GameSettingsEvent event) async* {
    if(event is ReloadEvent) yield* _handleReloadEvent(event);
    if (event is ToggleMusicEvent) yield* _handleToggleMusicEvent(event);
    if (event is ToggleSFXEvent) yield* _handleToggleSFXEvent(event);
    if (event is ToggleNotificationsEvent) yield* _handleToggleNotificationsEvent(event);
  }

  Stream<GameSettingsState> _handleReloadEvent(ReloadEvent event) async* {
    var settings = await repository.fetch();
    _currentSettings = transformEntity(settings);
    _initialized = true;
    yield ReloadedState(_currentSettings);
  }

  Stream<GameSettingsState> _handleToggleMusicEvent(ToggleMusicEvent event) async*{
    bool newValue = ! _currentSettings.music;
    var newSettings = _currentSettings.copyWith(music: newValue);
    var success = await _transformThemeAndUpdate(repository, newSettings);

    if(success) {
      _currentSettings = newSettings;
      yield newValue ? MusicOnState() : MusicOffState();
    }
  }

  Stream<GameSettingsState> _handleToggleSFXEvent(ToggleSFXEvent event) async*{
    bool newValue = ! _currentSettings.sfx;
    var newSettings = _currentSettings.copyWith(sfx: newValue);
    var success = await _transformThemeAndUpdate(repository, newSettings);
    
    if(success) {
      _currentSettings = newSettings;
      yield newValue ? SFXOnState() : SFXOffState();
    }
  }

  Stream<GameSettingsState> _handleToggleNotificationsEvent(ToggleNotificationsEvent event) async*{
    bool newValue = ! _currentSettings.notifications;
    var newSettings = _currentSettings.copyWith(notifications: newValue);
    var success = await _transformThemeAndUpdate(repository, newSettings);
    
    if(success) {
      _currentSettings = newSettings;
      yield newValue ? NotificationsOnState() : NotificationsOffState();
    }
  }
}
