import 'package:minesweeper_flutter/constants/db_keys.dart';

class GameSettings {
  final bool music;

  final bool sfx;

  final bool notifications;

  GameSettings({
    this.music = true,
    this.sfx = true,
    this.notifications = true,
  });

  GameSettings.fromMap(Map<String, dynamic> map)
      : music = map[ksGameSettingsMusic] > 0,
        sfx = map[ksGameSettingsSFX] > 0,
        notifications = map[ksGameSettingsNotifications] > 0;

  GameSettings copyWith({bool? music, bool? effects, bool? notifications}) {
    return GameSettings(
      music: music ?? this.music,
      sfx: effects ?? this.sfx,
      notifications: notifications ?? this.notifications,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map.putIfAbsent(ksGameSettingsMusic, () => this.music ? 1 : 0);
    map.putIfAbsent(ksGameSettingsSFX, () => this.sfx ? 1 : 0);
    map.putIfAbsent(ksGameSettingsNotifications, () => this.notifications ? 1 : 0);
    return map;
  }
}