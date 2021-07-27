import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_flutter/bloc/level_settings.dart';
import 'package:minesweeper_flutter/entities/level_settings_entity.dart';
import 'package:minesweeper_flutter/model/level_settings.dart';
import 'package:minesweeper_flutter/repository/level_settings_repository.dart';
import 'package:minesweeper_flutter/services/transformers/entity_transformer.dart';
import 'package:minesweeper_flutter/services/transformers/model_transformer.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements LevelSettingsRepository {}

void main() {
  late LevelSettingsRepository repository;
  late LevelSettingsBloc bloc;
  late LevelSettings settings;

  setUp(() {
    repository = MockRepository();
    bloc = LevelSettingsBloc(repository: repository);
    settings = LevelSettings(
      height: GameDifficulty.intermediate.height,
      width: GameDifficulty.intermediate.width,
      mines: GameDifficulty.intermediate.mines,
      mode: GameMode.standard,
      difficulty: GameDifficulty.intermediate,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test("Initial state should be InitialState", () {
    expect(bloc.state, InitialState());
  });

  test(
      "Initial current settings value is standard game mode, intermediate difficulty, and default values",
      () {
    expect(bloc.currentSettings, settings);
  });

  test("No states emitted after closing", () {
    expectLater(bloc.stream, emitsInOrder([emitsDone]));
    bloc.close();
  });

  test("Adding ReloadEvent should emit LoadingState -> SettingsUpdatedState",
      () {
    final expectedResult = [LoadingState, SettingsUpdatedState];

    when(() => repository.fetchSettings()).thenAnswer((invocation) =>
        Future(() => transformModel<LevelSettingsEntity>(settings)));

    bloc.add(ReloadEvent());

    expectLater(
        bloc.stream.map((e) => e.runtimeType), emitsInOrder(expectedResult));
  });

  test(
      "Adding MinesChangedEvent emits LoadingState -> MinesUpdatedState, and updates currentSettings",
      () {
    int newMinesValue = 80;
    var expectedNewSettings = settings.copyWith(mines: newMinesValue);

    when(() => repository.updateSettings(
            transformModel<LevelSettingsEntity>(expectedNewSettings)))
        .thenAnswer((invocation) => Future(() => true));

    bloc.add(MinesChangedEvent(newMinesValue));

    expectLater(bloc.stream,
            emitsInOrder([LoadingState(), MinesUpdatedState(newMinesValue)]))
        .then((value) => expect(bloc.currentSettings, expectedNewSettings));
  });

  test(
      "Adding HeightChangedEvent emits LoadingState -> HeightUpdatedState, and updates currentSettings",
      () {
    int newValue = 80;
    var expectedNewSettings = settings.copyWith(height: newValue);

    when(() => repository.updateSettings(
            transformModel<LevelSettingsEntity>(expectedNewSettings)))
        .thenAnswer((invocation) => Future(() => true));

    bloc.add(HeightChangedEvent(newValue));

    expectLater(bloc.stream,
            emitsInOrder([LoadingState(), HeightUpdatedState(newValue)]))
        .then((value) => expect(bloc.currentSettings, expectedNewSettings));
  });

  
  test(
      "Adding WidthChangedEvent emits LoadingState -> WidthUpdatedState, and updates currentSettings",
      () {
    int newValue = 80;
    var expectedNewSettings = settings.copyWith(width: newValue);

    when(() => repository.updateSettings(
            transformModel<LevelSettingsEntity>(expectedNewSettings)))
        .thenAnswer((invocation) => Future(() => true));

    bloc.add(WidthChangedEvent(newValue));

    expectLater(bloc.stream,
            emitsInOrder([LoadingState(), WidthUpdatedState(newValue)]))
        .then((value) => expect(bloc.currentSettings, expectedNewSettings));
  });

 test(
      "Adding DifficultyChangedEvent emits LoadingState -> DifficultyUpdatedState, and updates currentSettings",
      () {
    var newValue = GameDifficulty.hard;
    var expectedNewSettings = settings.copyWith(difficulty: newValue);

    when(() => repository.updateSettings(
            transformModel<LevelSettingsEntity>(expectedNewSettings)))
        .thenAnswer((invocation) => Future(() => true));

    bloc.add(DifficultyChangedEvent(newValue));

    expectLater(bloc.stream,
            emitsInOrder([LoadingState(), DifficultyUpdatedState(newValue)]))
        .then((value) => expect(bloc.currentSettings, expectedNewSettings));
  });

   test(
      "Adding GameModeChangedEvent emits LoadingState -> GameModeUpdatedState, and updates currentSettings",
      () {
    var newValue = GameMode.endless;
    var expectedNewSettings = settings.copyWith(mode: newValue);

    when(() => repository.updateSettings(
            transformModel<LevelSettingsEntity>(expectedNewSettings)))
        .thenAnswer((invocation) => Future(() => true));

    bloc.add(GameModeChangedEvent(newValue));

    expectLater(bloc.stream,
            emitsInOrder([LoadingState(), GameModeUpdatedState(newValue)]))
        .then((value) => expect(bloc.currentSettings, expectedNewSettings));
  });
}
