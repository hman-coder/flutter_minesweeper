import 'package:equatable/equatable.dart';
import 'package:minesweeper_flutter/constants/db_keys.dart';

class GameSettings extends Equatable {
  final bool music;

  final bool sfx;

  final bool notifications;

  GameSettings({
    this.music = true,
    this.sfx = true,
    this.notifications = true,
  });

  GameSettings.fromMap(Map<String, dynamic> map)
      : music = map[kkGameSettingsMusic] > 0,
        sfx = map[kkGameSettingsSFX] > 0,
        notifications = map[kkGameSettingsNotifications] > 0;

  GameSettings copyWith({bool? music, bool? sfx, bool? notifications}) {
    return GameSettings(
      music: music ?? this.music,
      sfx: sfx ?? this.sfx,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [music, sfx, notifications];
}