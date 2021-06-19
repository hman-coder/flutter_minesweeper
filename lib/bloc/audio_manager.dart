import 'package:audioplayers/audioplayers.dart';
import 'package:minesweeper_flutter/constants/audio.dart';

class AudioManager {
  final AudioCache _cache;

  static final AudioManager _instance = AudioManager._();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._() : _cache = AudioCache(prefix: ksAssetsPrefix) {
    _init();
  }

  void _init() {
    _cache.load(ksNormalClick);
  }

  void normalClick() => _cache.play(ksNormalClick);
}
