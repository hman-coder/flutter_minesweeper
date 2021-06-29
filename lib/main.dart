import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart';
import 'package:minesweeper_flutter/bloc/unlocked_features_bloc.dart';
import 'package:minesweeper_flutter/bloc/bloc_observer.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
import 'package:minesweeper_flutter/repository/game_settings_repository.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';
import 'package:minesweeper_flutter/config/route_generators.dart';
import 'package:minesweeper_flutter/bloc/game_settings_bloc.dart';
import 'package:flutter_gen/gen_l10n/minesweeper_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MinesweeperBlocObserver();
  runApp(MinesweeperApp());
}

class MinesweeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ThemeTestApp();
    return MultiBlocProvider(
      providers: [
        BlocProvider<MinesweeperThemeBloc>(
          lazy: false,
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
              cur is BackgroundColorUpdatedState || cur is InitialState || cur is ThemeReloadedState,
          builder: (context, state) {
            ThemeData theme = context.read<MinesweeperThemeBloc>().currentTheme.appTheme;
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
