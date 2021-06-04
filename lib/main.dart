import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart';
import 'package:minesweeper_flutter/presentation/ui/loading_ui.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';
import 'package:minesweeper_flutter/config/text_theme_config.dart';

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
          fontFamily: kffFontFamily,
          textTheme: kttMainTextTheme,
        ),
        home: LoadingUI(),
      ),
    );
  }
}
