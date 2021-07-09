import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:minesweeper_flutter/bloc/audio_manager.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart' as gameTheme;
import 'package:minesweeper_flutter/bloc/unlocked_features_bloc.dart';
import 'package:minesweeper_flutter/bloc/bloc_observer.dart';
import 'package:minesweeper_flutter/config/themes/neumorphic_light.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
import 'package:minesweeper_flutter/repository/game_settings_repository.dart';
import 'package:minesweeper_flutter/repository/minesweeper_theme_repository.dart';
import 'package:minesweeper_flutter/config/route_generators.dart';
import 'package:minesweeper_flutter/bloc/game_settings.dart' as gameSettings;
import 'package:flutter_gen/gen_l10n/minesweeper_localizations.dart';
import 'package:minesweeper_flutter/config/themes.dart';

import 'constants/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MinesweeperBlocObserver();
  runApp(MinesweeperApp());
}

class MinesweeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CoreBlocsProvider(
      child: BlocBuilder<gameTheme.MinesweeperThemeBloc,
              gameTheme.MinesweeperThemeState>(
          buildWhen: _rebuildWhen,
          builder: (context, state) {
            ThemeData theme = context
                .read<gameTheme.MinesweeperThemeBloc>()
                .currentTheme
                .appTheme;
            return NeumorphicTheme(
              darkTheme: kntdDarkNeumorphicTheme,
              theme: kndtLightNeumorphicTheme,
              themeMode: context.watch<gameTheme.MinesweeperThemeBloc>().currentTheme.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
              child: MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                debugShowCheckedModeBanner: false,
                theme: theme,
                onGenerateRoute: materialRouteGenerator,
                initialRoute: kprLoadingRoute,
              ),
            );
          }),
    );
  }

  bool _rebuildWhen(prev, cur) {
    return cur is gameTheme.BackgroundColorUpdatedState ||
        cur is gameTheme.InitialState ||
        cur is gameTheme.ThemeReloadedState;
  }
}

class CoreBlocsProvider extends StatefulWidget {
  final Widget child;

  CoreBlocsProvider({required this.child, Key? key}) : super(key: key);

  @override
  _CoreBlocsProviderState createState() => _CoreBlocsProviderState();
}

class _CoreBlocsProviderState extends State<CoreBlocsProvider> {
  late gameTheme.MinesweeperThemeBloc _themeBloc;
  late UnlockedFeaturesBloc _featuresBloc;
  late gameSettings.GameSettingsBloc _gameSettingsBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc =
        gameTheme.MinesweeperThemeBloc(MinesweeperThemeSqliteRepository());
    _featuresBloc = UnlockedFeaturesBloc(_themeBloc);
    _gameSettingsBloc =
        gameSettings.GameSettingsBloc(GameSettingsSqliteRepository());

    AudioManager.initialize(_gameSettingsBloc);
    _themeBloc.add(gameTheme.ReloadEvent());
    _gameSettingsBloc.add(gameSettings.ReloadEvent());
  }

  @override
  void dispose() {
    _themeBloc.close();
    _featuresBloc.close();
    _gameSettingsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<gameTheme.MinesweeperThemeBloc>.value(
          value: _themeBloc,
        ),
        BlocProvider<gameSettings.GameSettingsBloc>.value(
          value: _gameSettingsBloc,
        ),
        BlocProvider<UnlockedFeaturesBloc>.value(
          value: _featuresBloc,
        )
      ],
      child: Builder(
        builder: (context) => widget.child,
        // AnimatedSwitcher(
        //   transitionBuilder: (child, animation) => FadeTransition(
        //     opacity: animation,
        //     child: child,
        //   ),
        //   duration: Duration(milliseconds: 1000),
        //   child: context.read<gameTheme.MinesweeperThemeBloc>().initialized
        //       ? widget.child
        //       : Container(),
        // ),
      ),
    );
  }
}
