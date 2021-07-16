import 'package:equatable/equatable.dart';
import 'package:minesweeper_flutter/constants/db_keys.dart';

import 'entity.dart';

class GameSettingsEntity extends Entity with EquatableMixin {
  final int music;

  final int sfx;

  final int notifications;

  GameSettingsEntity({
    required this.music,
    required this.sfx,
    required this.notifications,
  });

  GameSettingsEntity.fromMap(Map<String, dynamic> map) :
    this.music = map[kkGameSettingsMusic],
    this.sfx = map[kkGameSettingsSFX],
    this.notifications = map[kkGameSettingsNotifications],
    super()
  ;

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map[kkGameSettingsMusic] = this.music;
    map[kkGameSettingsSFX]= this.sfx;
    map[kkGameSettingsNotifications] = this.notifications;
    return map;
  }

  @override
  List<Object?> get props => [music, sfx, notifications];
}
