import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart';
import 'package:minesweeper_flutter/bloc/unlocked_features_bloc.dart';
import 'package:minesweeper_flutter/bloc/bloc_observer.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
import 'package:minesweeper_flutter/model/unlockable_features.dart';
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
    return CoreBlocsProvider(
      child: BlocBuilder<MinesweeperThemeBloc, MinesweeperThemeState>(
          buildWhen: _rebuildWhen,
          builder: (context, state) {
            ThemeData theme =
                context.read<MinesweeperThemeBloc>().currentTheme.appTheme;
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

  bool _rebuildWhen(prev, cur) {
    print("checking rebuild");
    return cur is BackgroundColorUpdatedState ||
        cur is InitialState ||
        cur is ThemeReloadedState;
  }
}

class CoreBlocsProvider extends StatefulWidget {
  final Widget child;

  CoreBlocsProvider({required this.child, Key? key}) : super(key: key);

  @override
  _CoreBlocsProviderState createState() => _CoreBlocsProviderState();
}

class _CoreBlocsProviderState extends State<CoreBlocsProvider> {
  late MinesweeperThemeBloc _themeBloc;
  late UnlockedFeaturesBloc _featuresBloc;
  late GameSettingsBloc _gameSettingsBloc;

  @override
  void initState() {
    _themeBloc = MinesweeperThemeBloc(MinesweeperThemeSqliteRepository())
      ..add(ReloadEvent());
    _featuresBloc = UnlockedFeaturesBloc(_themeBloc);
    _gameSettingsBloc = GameSettingsBloc(GameSettingsSqliteRepository());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MinesweeperThemeBloc>.value(
          value: _themeBloc,
        ),
        BlocProvider<GameSettingsBloc>.value(
          value: _gameSettingsBloc,
        ),
        BlocProvider<UnlockedFeaturesBloc>.value(
          value: _featuresBloc,
        )
      ],
      child: Builder(
        builder: (context) => AnimatedSwitcher(
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          duration: Duration(milliseconds: 1000),
          child: context.read<MinesweeperThemeBloc>().initialized
              ? widget.child
              : Container(),
        ),
      ),
    );
  }
}
