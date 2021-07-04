import 'package:audioplayers/audioplayers.dart';
import 'package:minesweeper_flutter/bloc/game_settings.dart';
import 'package:minesweeper_flutter/constants/audio.dart';

class AudioManager {
  static late final AudioManager _instance;

  static void initialize(GameSettingsBloc _bloc) {
    _instance = AudioManager._(_bloc);
  }

  factory AudioManager() {
    return _instance;
  }

  final AudioCache _cache;

  final GameSettingsBloc _settingsBloc;

  bool _playMusic = false;

  bool _playSFX = false;

  AudioManager._(this._settingsBloc) : _cache = AudioCache(prefix: ksAssetsPrefix) {
    _init();
  }

  void _init() {
    _loadAudioFiles();
    _listenToSettingsChanges();
  }

  void _loadAudioFiles() {
    _cache.load(ksNormalClick);
    _cache.load(ksToggle);
  }

  void _listenToSettingsChanges() {
    _settingsBloc.stream.listen((state) {
      if (state is ReloadedState) {
        _playMusic = _settingsBloc.settings.music;
        _playSFX = _settingsBloc.settings.sfx;
      } else if (state is MusicOnState) _playMusic = true;
      else if (state is MusicOffState) _playMusic = false;
      else if (state is SFXOnState) _playSFX = true;
      else if (state is SFXOffState) _playSFX = false;
     });
  }

  void normalClick() {
    if(_playSFX) _cache.play(ksNormalClick);
  }

  void toggle() {
    if(_playSFX) _cache.play(ksToggle);
  }

  void selectedItemChanged() => normalClick();
}
