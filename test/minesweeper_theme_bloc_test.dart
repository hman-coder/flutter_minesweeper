import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:flutter/material.dart';

class MockThemeRepository extends Mock implements MinesweeperThemeRepository {}

void main() {
  late MinesweeperThemeRepository _repo;
  late MinesweeperThemeBloc _bloc;

  final MinesweeperTheme initialTheme = MinesweeperTheme.initial();
  final Color testColor = Colors.yellow;
  final IconData testIcon = Icons.ac_unit_sharp;

  setUp(() {
    _repo = MockThemeRepository();
    _bloc = MinesweeperThemeBloc(_repo);
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
        Future(() => initialTheme));

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

  test(
      "Adding TileAnimationChangeEvent emits a correct TileAnimationUpdatedState",
      () {
    TileAnimation tileAnimation = TileAnimation.test;

    when(() =>
            _repo.update(initialTheme.copyWith(tileAnimation: tileAnimation)))
        .thenAnswer((invocation) => Future(() => true));

    expectLater(
        _bloc.stream, emitsInOrder([TileAnimationUpdatedState(tileAnimation)]));

    _bloc.add(TileAnimationChangeEvent(tileAnimation));
  });

  test("Adding ReloadEvent emits a correct ThemeUpdatedState", () {
    when(() => _repo.fetchTheme()).thenAnswer((invocation) =>
        Future(() => initialTheme.copyWith(backgroundColor: testColor)));

    expectLater(
        _bloc.stream,
        emitsInOrder([
          ThemeReloadedState(initialTheme.copyWith(backgroundColor: testColor))
        ]));

    _bloc.add(ReloadEvent());
  });

  test("Adding ReloadEvent sets initialized to true", () {
    when(() => _repo.fetchTheme())
        .thenAnswer((invocation) => Future(() => initialTheme));

    expectLater(
        _bloc.stream.map((_) => _bloc.initialized), emitsInOrder([true]));
    _bloc.add(ReloadEvent());
  });

  test("Adding BackgroundColorChangeEvent changes the backgroundColor", () {
    MinesweeperTheme modifiedTheme =
        initialTheme.copyWith(backgroundColor: testColor);
    when(() => _repo.update(modifiedTheme))
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
        colorModifiedMineTheme.copyWith(icon: testIcon);
    MinesweeperElementTheme modifiedMineTheme = initialTheme.mineTheme;

    when(() => _repo
            .update(initialTheme.copyWith(mineTheme: colorModifiedMineTheme)))
        .thenAnswer((invocation) => Future(() => true));
    when(() => _repo
            .update(initialTheme.copyWith(mineTheme: iconModifiedMineTheme)))
        .thenAnswer((invocation) => Future(() => true));
    when(() =>
            _repo.update(initialTheme.copyWith(mineTheme: modifiedMineTheme)))
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
        colorModifiedFlagTheme.copyWith(icon: testIcon);
    MinesweeperElementTheme modifiedFlagTheme = initialTheme.flagTheme;

    when(() => _repo
            .update(initialTheme.copyWith(flagTheme: colorModifiedFlagTheme)))
        .thenAnswer((invocation) => Future(() => true));
    when(() => _repo
            .update(initialTheme.copyWith(flagTheme: iconModifiedFlagTheme)))
        .thenAnswer((invocation) => Future(() => true));
    when(() =>
            _repo.update(initialTheme.copyWith(flagTheme: modifiedFlagTheme)))
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
        colorModifiedTileTheme.copyWith(icon: testIcon);
    MinesweeperElementTheme modifiedTileTheme = initialTheme.tileTheme;

    when(() => _repo
            .update(initialTheme.copyWith(tileTheme: colorModifiedTileTheme)))
        .thenAnswer((invocation) => Future(() => true));
    when(() => _repo
            .update(initialTheme.copyWith(tileTheme: iconModifiedTileTheme)))
        .thenAnswer((invocation) => Future(() => true));
    when(() =>
            _repo.update(initialTheme.copyWith(tileTheme: modifiedTileTheme)))
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
