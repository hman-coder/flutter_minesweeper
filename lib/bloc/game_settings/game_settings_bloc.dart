import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/model/game_settings.dart';
import 'package:minesweeper_flutter/repository/game_settings_repository.dart';

class GameSettingsBloc extends Cubit<GameSettings> {
  final GameSettingsRepository repository;

  GameSettingsBloc(this.repository)
      : super(
          GameSettings(
            music: false,
            sfx: false,
            notifications: false,
          ),
        );

  void load() async {
    try {
      var data = await repository.fetch();
      emit(data);
    } catch (err) {
      print(err);
    }
  }

  void toggleMusic() {
    var data = state.copyWith(music: !state.music);
    // TODO: STORE CHANGED SETTINGS
    emit(data);
  }

  void toggleSFX() {
    var data = state.copyWith(effects: !state.sfx);
    // TODO: STORE CHANGED SETTINGS
    emit(data);
  }

  void toggleNotifications() {
    var data = state.copyWith(notifications: !state.notifications);
    // TODO: STORE CHANGED SETTINGS
    emit(data);
  }
}
