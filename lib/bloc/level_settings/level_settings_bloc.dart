import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/model/level_settings.dart';
import 'package:minesweeper_flutter/repository/level_settings_repository.dart';

import 'level_settings_event.dart';
import 'level_settings_state.dart';

class LevelSettingsBloc extends Bloc<LevelSettingsEvent, LevelSettingsState> {
  late final LevelSettingsRepository repository;

  LevelSettings? _currentSettings;

  LevelSettingsBloc({required this.repository}) : super(InitialState());

  @override
  Stream<LevelSettingsState> mapEventToState(LevelSettingsEvent event) async* {
    if(event is ReloadEvent) yield* _handleReloadEvent();
  }

  Stream<LevelSettingsState> _handleSettingsOptionChanged({int? height, int? width, int? mines}) async*{
    assert (height != null || width!= null || mines != null);
    yield LoadingState();
    var newSettings = _currentSettings!.copyWith(height: height, width: width, mines: mines);
    await repository.updateSettings(newSettings);
  }

  Stream<LevelSettingsState> _handleReloadEvent() async*{
    yield LoadingState();
    LevelSettings? settings;
    
    settings = await repository.fetchSettings();
    if(settings == null) settings = LevelSettings.fromDifficulty(GameDifficulty.beginner);
    _currentSettings = settings;
    yield SettingsUpdatedState(settings);
  }
} 