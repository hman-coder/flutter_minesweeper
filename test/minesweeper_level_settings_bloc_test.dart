
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_level_settings/minesweeper_level_settings_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_level_settings/minesweeper_level_settings_event.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_level_settings/minesweeper_level_settings_state.dart';
import 'package:minesweeper_flutter/repository/minesweeper_level_settings_repository.dart';
import 'package:minesweeper_flutter/model/minesweeper_level_settings.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements MinesweeperLevelSettingsRepository{}

class MockEntity extends MinesweeperLevelSettings with EquatableMixin{
  MockEntity() : super.custom(height: 10, width: 10, mines: 10);

  @override
  List<Object?> get props => [height, width, mines];
  
  
}


void main() {
  late MinesweeperLevelSettingsRepository repository;
  late MinesweeperLevelSettingsBloc bloc;

  setUp(() {
    repository = MockRepository();
    bloc = MinesweeperLevelSettingsBloc(repository: repository);
  });

  tearDown((){
    bloc.close();
  });

  test("Initial state should be InitialState", () {
    expect(bloc.state, InitialState());
  }); 

  test("No states emitted after closing", () {
    expectLater(bloc.stream, emitsInOrder([emitsDone]));
    bloc.close();
  });

  test("Adding ReloadThemeEvent should emit LoadingState -> ThemeUpdatedState", () {
    final expectedResult = [
      LoadingState, SettingsUpdatedState
    ];

    when(() => repository.fetchSettings()).thenAnswer((invocation) => Future(() => MockEntity()));

    bloc.add(ReloadEvent());

    expectLater(bloc.stream.map((e) => e.runtimeType), emitsInOrder(expectedResult));
  });
}