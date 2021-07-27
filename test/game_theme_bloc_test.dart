import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_flutter/entities/game_theme_entity.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/repository/game_theme_repository.dart';
import 'package:minesweeper_flutter/services/transformers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:minesweeper_flutter/bloc/game_theme.dart';
import 'package:minesweeper_flutter/model/game_theme.dart';
import 'package:flutter/material.dart';

class MockThemeRepository extends Mock implements GameThemeRepository {}

void main() {
  late GameThemeRepository _repo;
  late GameThemeBloc _bloc;

  final MinesweeperTheme initialTheme = MinesweeperTheme.initial();
  final Color testColor = Colors.yellow;

  setUp(() {
    _repo = MockThemeRepository();
    _bloc = GameThemeBloc(_repo);
  });

  tearDown(() {
    _bloc.close();
  });

  test("Checking initial state to be InitialState", () {
    expect(_bloc.state, InitialState());
  });

  test("Check initialized to be false at the beginning", () {
    expect(_bloc.initialized, false);
  });

  test("Check initialized to be true after adding the first ReloadEvent", () {
    when(() => _repo.fetchTheme()).thenAnswer((invocation) =>
        Future(() => transformModel<GameThemeEntity>(initialTheme)));

    expectLater(_bloc.stream.map((event) => _bloc.initialized), emitsInOrder([true]));
    _bloc.add(ReloadEvent());
  });

  test("No states emitted after closing", () {
    expectLater(
      _bloc.stream,
      emitsInOrder([emitsDone]),
    );
    _bloc.close();
  });

  test("Adding ReloadEvent emits a correct ThemeUpdatedState", () {
    var updatedColor = initialTheme;

    when(() => _repo.fetchTheme()).thenAnswer((invocation) =>
        Future(() => transformModel<GameThemeEntity>(updatedColor)));

    expectLater(
        _bloc.stream,
        emitsInOrder([
          ThemeReloadedState(updatedColor)
        ]));

    _bloc.add(ReloadEvent());
  });

  test("Adding ReloadEvent sets initialized to true", () {
    when(() => _repo.fetchTheme())
        .thenAnswer((invocation) => Future(() => transformModel<GameThemeEntity>(initialTheme)));

    expectLater(
        _bloc.stream.map((_) => _bloc.initialized), emitsInOrder([true]));
    _bloc.add(ReloadEvent());
  });

  test(
      "Adding TileAnimationChangeEvent emits a correct TileAnimationUpdatedState",
      () {
    TileAnimation tileAnimation = TileAnimation.test;
    MinesweeperTheme updatedTheme = initialTheme.copyWith(tileAnimation: tileAnimation);
    when(() =>
            _repo.update(transformModel(updatedTheme)))
        .thenAnswer((invocation) => Future(() => true));

    expectLater(
        _bloc.stream, emitsInOrder([TileAnimationUpdatedState(tileAnimation)]));

    _bloc.add(TileAnimationChangeEvent(tileAnimation));
  });

  test("Adding BackgroundColorChangeEvent changes the backgroundColor", () {
    MinesweeperTheme modifiedTheme =
        initialTheme.copyWith(backgroundColor: testColor);
    when(() => _repo.update(transformModel(modifiedTheme)))
        .thenAnswer((invocation) => Future(() => true));

    expectLater(
        _bloc.stream, emitsInOrder([BackgroundColorUpdatedState(testColor)]));
    _bloc.add(BackgroundColorChangeEvent(testColor));
  });

  test(
      "Adding various MineThemeChangeedEvents emits a correct MineThemeUpdatedState",
      () {
    MinesweeperElementTheme colorModifiedMineTheme =
        initialTheme.mineTheme.copyWith(color: testColor);
    MinesweeperElementTheme iconModifiedMineTheme =
        colorModifiedMineTheme.copyWith(icon: MinesweeperIcons.flag);
    MinesweeperElementTheme modifiedMineTheme = initialTheme.mineTheme;

    when(() => _repo
            .update(transformModel(initialTheme.copyWith(mineTheme: colorModifiedMineTheme))))
        .thenAnswer((invocation) => Future(() => true));
    when(() => _repo
            .update(transformModel(initialTheme.copyWith(mineTheme: iconModifiedMineTheme))))
        .thenAnswer((invocation) => Future(() => true));
    when(() =>
            _repo.update(transformModel(initialTheme.copyWith(mineTheme: modifiedMineTheme))))
        .thenAnswer((invocation) => Future(() => true));

    expectLater(
        _bloc.stream,
        emitsInOrder([
          MineThemeUpdatedState(colorModifiedMineTheme),
          MineThemeUpdatedState(iconModifiedMineTheme),
          MineThemeUpdatedState(modifiedMineTheme),
        ]));
    _bloc.add(MineThemeChangeEvent(
      color: colorModifiedMineTheme.color,
    ));
    _bloc.add(MineThemeChangeEvent(
      icon: iconModifiedMineTheme.icon,
    ));
    _bloc.add(MineThemeChangeEvent(
        color: modifiedMineTheme.color, icon: modifiedMineTheme.icon));
  });

  test(
      "Adding various FlagThemeChangedEvents emits a correct FlagThemeUpdatedState",
      () {
    MinesweeperElementTheme colorModifiedFlagTheme =
        initialTheme.flagTheme.copyWith(color: testColor);
    MinesweeperElementTheme iconModifiedFlagTheme =
        colorModifiedFlagTheme.copyWith(icon: MinesweeperIcons.mine);
    MinesweeperElementTheme modifiedFlagTheme = initialTheme.flagTheme;

    when(() => _repo
            .update(transformModel(initialTheme.copyWith(flagTheme: colorModifiedFlagTheme))))
        .thenAnswer((invocation) => Future(() => true));
    when(() => _repo
            .update(transformModel(initialTheme.copyWith(flagTheme: iconModifiedFlagTheme))))
        .thenAnswer((invocation) => Future(() => true));
    when(() =>
            _repo.update(transformModel(initialTheme.copyWith(flagTheme: modifiedFlagTheme))))
        .thenAnswer((invocation) => Future(() => true));

    expectLater(
        _bloc.stream,
        emitsInOrder([
          FlagThemeUpdatedState(colorModifiedFlagTheme),
          FlagThemeUpdatedState(iconModifiedFlagTheme),
          FlagThemeUpdatedState(modifiedFlagTheme),
        ]));
    _bloc.add(FlagThemeChangeEvent(
      color: colorModifiedFlagTheme.color,
    ));
    _bloc.add(FlagThemeChangeEvent(
      icon: iconModifiedFlagTheme.icon,
    ));
    _bloc.add(FlagThemeChangeEvent(
        color: modifiedFlagTheme.color, icon: modifiedFlagTheme.icon));
  });

  test(
      "Adding various TileThemeChangedEvents emits a correct TileThemeUpdatedState",
      () {
    MinesweeperElementTheme colorModifiedTileTheme =
        initialTheme.tileTheme.copyWith(color: testColor);
    MinesweeperElementTheme iconModifiedTileTheme =
        colorModifiedTileTheme.copyWith(icon: MinesweeperIcons.mine);
    MinesweeperElementTheme modifiedTileTheme = initialTheme.tileTheme;

    when(() => _repo
            .update(transformModel(initialTheme.copyWith(tileTheme: colorModifiedTileTheme))))
        .thenAnswer((invocation) => Future(() => true));
    when(() => _repo
            .update(transformModel(initialTheme.copyWith(tileTheme: iconModifiedTileTheme))))
        .thenAnswer((invocation) => Future(() => true));
    when(() =>
            _repo.update(transformModel(initialTheme.copyWith(tileTheme: modifiedTileTheme))))
        .thenAnswer((invocation) => Future(() => true));

    expectLater(
        _bloc.stream,
        emitsInOrder([
          TileThemeUpdatedState(colorModifiedTileTheme),
          TileThemeUpdatedState(iconModifiedTileTheme),
          TileThemeUpdatedState(modifiedTileTheme),
        ]));
    _bloc.add(TileThemeChangeEvent(
      color: colorModifiedTileTheme.color,
    ));
    _bloc.add(TileThemeChangeEvent(
      icon: iconModifiedTileTheme.icon,
    ));
    _bloc.add(TileThemeChangeEvent(
        color: modifiedTileTheme.color, icon: modifiedTileTheme.icon));
  });
}
