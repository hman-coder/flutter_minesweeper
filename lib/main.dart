import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme_bloc.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
import 'package:minesweeper_flutter/repository/game_settings_repository.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';
import 'package:minesweeper_flutter/constants/text.dart';
import 'package:minesweeper_flutter/config/themes.dart';
import 'package:minesweeper_flutter/config/route_generators.dart';
import 'package:minesweeper_flutter/bloc/game_settings_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MinesweeperThemeBloc>(
            create: (context) =>
                MinesweeperThemeBloc(MinesweeperThemeSqliteRepository())),
        BlocProvider<GameSettingsBloc>(
            create: (context) =>
                GameSettingsBloc(GameSettingsSqliteRepository())..load()),
      ],
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
