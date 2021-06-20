import 'package:audioplayers/audioplayers.dart';
import 'package:minesweeper_flutter/constants/audio.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._();

  factory AudioManager() {
    return _instance;
  }

  final AudioCache _cache;

  AudioManager._() : _cache = AudioCache(prefix: ksAssetsPrefix) {
    _init();
  }

  void _init() {
    _cache.load(ksNormalClick);
    _cache.load(ksToggle);
  }

  void normalClick() => _cache.play(ksNormalClick);

  void toggle() => _cache.play(ksToggle);
}
