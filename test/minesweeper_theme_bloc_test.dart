import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart';
import 'package:minesweeper_flutter/model/minesweeper_theme.dart';
import 'package:minesweeper_flutter/entities/minesweeper_theme_entity.dart';

class MockThemeRepository extends Mock implements MinesweeperThemeRepository {}

class MockTheme extends Mock implements MinesweeperTheme {}

class MockThemeEntity extends MinesweeperThemeEntity with EquatableMixin{
  MockThemeEntity() : super(
    flagIconPath: "",
    foregroundColorValue: 1,
    mineIconPath: "",
    tileBackgroundColorValue: 1,
    tileShape: "circle"
  );

  @override
  List<Object?> get props => [];
}

void main() {
  late MinesweeperThemeRepository _repo;
  late MinesweeperThemeBloc _bloc;

  setUp(() {
    _repo = MockThemeRepository();
    _bloc = MinesweeperThemeBloc(_repo);
  });

  tearDown(() {
    _bloc.close();
  });

  test("Checking initial state to be LoadingState", () {
    expect(_bloc.state, LoadingState());
  });

  test("No states emitted after closing", () {
    expectLater(
      _bloc.stream,
      emitsInOrder([emitsDone]),
    );
    _bloc.close();
  });

  test("Adding ReloadThemeEvent should emit LoadingState -> ThemeUpdatedState", () {
    final expectedResult = [
      LoadingState, ThemeUpdatedState
    ];

    // When the _bloc calls [_repo.fetchTheme()] a future with mock entity will be returned
    when(() => _repo.fetchTheme()).thenAnswer((invocation) => Future(() => MockThemeEntity()));

    _bloc.add(ReloadThemeEvent());

    expectLater(_bloc.stream.map((e) => e.runtimeType), emitsInOrder(expectedResult));
  });
}