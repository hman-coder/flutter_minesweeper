import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';
import 'package:minesweeper_flutter/constants/text.dart';
import 'package:minesweeper_flutter/config/themes.dart';
import 'package:minesweeper_flutter/config/route_generators.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MinesweeperThemeBloc _createMinesweeperThemeBloc() =>
      MinesweeperThemeBloc(MinesweeperSqliteThemeRepository())
        ..add(ReloadThemeEvent());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MinesweeperThemeBloc>(
      create: (context) => _createMinesweeperThemeBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textButtonTheme: kbtTextButtonTheme,
          outlinedButtonTheme: kbtOutlinedButtonTheme,
          fontFamily: kffFontFamily,
          textTheme: kttMainTextTheme,
          appBarTheme: kabtAppBarTheme,
        ),

        onGenerateRoute: materialRouteGenerator,
        initialRoute: kprLoadingRoute,
      ),
    );
  }
}
