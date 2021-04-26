import 'package:equatable/equatable.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';

abstract class MinesweeperThemeState extends Equatable{
  @override  
  List<Object?> get props => [];
}

class LoadingState extends MinesweeperThemeState {
  
}

class ThemeUpdatedState extends MinesweeperThemeState {
  final MinesweeperTheme newConfig;

  ThemeUpdatedState(this.newConfig);

  @override
  List<Object?> get props => [newConfig];

}