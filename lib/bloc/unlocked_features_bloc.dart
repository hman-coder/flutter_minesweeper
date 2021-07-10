import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart';
import 'package:minesweeper_flutter/model/unlockable_features.dart';

class UnlockedFeaturesBloc extends Cubit<UnlockableFeatures> {
  final MinesweeperThemeBloc _themeBloc;

  UnlockedFeaturesBloc(this._themeBloc) : super(UnlockableFeatures.light()) {
    _init();
  }

  _init() {
    _themeBloc.stream.listen((state) {
      if (state is BackgroundColorUpdatedState ||
          state is InitialState ||
          state is ThemeReloadedState) {
        if (_themeBloc.currentTheme.isDarkTheme) {
          emit(UnlockableFeatures.dark());
          
        } else {
          emit(UnlockableFeatures.light());
          
        }
      }
    });
  }
}
