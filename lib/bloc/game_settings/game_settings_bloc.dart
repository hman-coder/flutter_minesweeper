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
    var data = await repository.fetch();
    if(data != null)
      emit(data);

    else emit(GameSettings());
  }

  void toggleMusic() async {
    var data = state.copyWith(music: !state.music);
    await repository.update(data);
    emit(data);
  }

  void toggleSFX() async {
    var data = state.copyWith(effects: !state.sfx);
    await repository.update(data);
    emit(data);
  }

  void toggleNotifications() async {
    var data = state.copyWith(notifications: !state.notifications);
    await repository.update(data);
    emit(data);
  }
}
