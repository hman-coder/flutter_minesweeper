class GameSettings {
  final bool music;

  final bool sfx;

  final bool notifications;

  GameSettings({
    required this.music,
    required this.sfx,
    required this.notifications,
  });

  GameSettings.fromMap(Map<String, dynamic> map)
      : music = map['music'],
        sfx = map['sfx'],
        notifications = map['notifications'];

  GameSettings copyWith({bool? music, bool? effects, bool? notifications}) {
    return GameSettings(
      music: music ?? this.music,
      sfx: effects ?? this.sfx,
      notifications: notifications ?? this.notifications,
    );
  }
}
