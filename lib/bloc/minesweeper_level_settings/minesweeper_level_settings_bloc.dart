import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_level_settings/minesweeper_level_settings_event.dart';
import 'package:minesweeper_flutter/model/minesweeper_level_settings.dart';
import 'package:minesweeper_flutter/repository/minesweeper_level_settings_repository.dart';

import 'minesweeper_level_settings_state.dart';

class MinesweeperLevelSettingsBloc extends Bloc<MinesweeperLevelSettingsEvent, MinesweeperLevelSettingsState> {
  late final MinesweeperLevelSettingsRepository repository;

  MinesweeperLevelSettings? _currentSettings;

  MinesweeperLevelSettingsBloc({required this.repository}) : super(InitialState());

  @override
  Stream<MinesweeperLevelSettingsState> mapEventToState(MinesweeperLevelSettingsEvent event) async* {
    if(event is ReloadEvent) yield* _handleReloadEvent();
  }

  Stream<MinesweeperLevelSettingsState> _handleSettingsOptionChanged({int? height, int? width, int? mines}) async*{
    assert (height != null || width!= null || mines != null);
    yield LoadingState();
    var newSettings = _currentSettings!.copyWith(height: height, width: width, mines: mines);
    await repository.updateSettings(newSettings);
  }

  Stream<MinesweeperLevelSettingsState> _handleReloadEvent() async*{
    yield LoadingState();
    MinesweeperLevelSettings? settings;
    
    settings = await repository.fetchSettings();
    if(settings == null) settings = MinesweeperLevelSettings.fromDifficulty(GameDifficulty.beginner);
    _currentSettings = settings;
    yield SettingsUpdatedState(settings);
  }
} 