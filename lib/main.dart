import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart';
import 'package:minesweeper_flutter/bloc/unlocked_features_bloc.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
import 'package:minesweeper_flutter/repository/game_settings_repository.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';
import 'package:minesweeper_flutter/config/themes.dart';
import 'package:minesweeper_flutter/constants/colors.dart';
import 'package:minesweeper_flutter/config/route_generators.dart';
import 'package:minesweeper_flutter/bloc/game_settings_bloc.dart';
import 'package:flutter_gen/gen_l10n/minesweeper_localizations.dart';

void main() {
  runApp(MinesweeperApp());
}

class MinesweeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ThemeTestApp();
    return MultiBlocProvider(
      providers: [
        BlocProvider<MinesweeperThemeBloc>(
            create: (context) =>
                MinesweeperThemeBloc(MinesweeperThemeSqliteRepository())),
        BlocProvider<GameSettingsBloc>(
            create: (context) =>
                GameSettingsBloc(GameSettingsSqliteRepository())),
        BlocProvider<UnlockedFeaturesBloc>(
            create: (context) => UnlockedFeaturesBloc())
      ],
      child: BlocBuilder<MinesweeperThemeBloc, MinesweeperThemeState>(
          buildWhen: (prev, cur) =>
              cur is BackgroundColorChangeState || cur is InitialState,
          builder: (context, state) {
            ThemeData theme = lightThemeData;
            if (state is BackgroundColorChangeState)
              theme = state.color.isDark ? darkThemeData : lightThemeData;
            else if (state is InitialState)
              theme = state.theme.appTheme;

            return MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              theme: theme,
              onGenerateRoute: materialRouteGenerator,
              initialRoute: kprLoadingRoute,
            );
          }),
    );
  }
}
