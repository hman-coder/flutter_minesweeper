import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';

class MinesweeperThemeBloc extends Cubit<MinesweeperTheme> {
  MinesweeperThemeRepository repository;

  MinesweeperThemeBloc(this.repository) : super(MinesweeperTheme.initial()) {
    load();
  }
  void load() async {
    var newTheme = await repository.fetchTheme();
    emit(newTheme);
  }

  void changeFlagColor(Color color) async {
    var newTheme = state.copyWith(flagColor: color);
    await repository.update(newTheme);
    emit(newTheme);
  }

  void changeFlagIcon(IconData icon) async {
    var newTheme = state.copyWith(flagIcon: icon);
    await repository.update(newTheme);
    emit(newTheme);
  }

  void changeMineColor(Color color) async {
    var newTheme = state.copyWith(mineColor: color);
    await repository.update(newTheme);
    emit(newTheme);
  }

  void changeMineIcon(IconData icon) async {
    var newTheme = state.copyWith(mineIcon: icon);
    await repository.update(newTheme);
    emit(newTheme);
  }
}
