import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/level_settings/level_settings_bloc.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
import 'package:minesweeper_flutter/presentation/ui/new_game_ui.dart';
import 'package:minesweeper_flutter/presentation/ui/uis.dart';
import 'package:minesweeper_flutter/repository/level_settings_repository.dart';

Route Function(RouteSettings settings) materialRouteGenerator = (settings) {
  print(settings.name);
  switch (settings.name) {
    case kprMainMenuRoute:
      return CustomMaterialPageRoute(builder: (context) => MainMenuUI());
    case kprLoadingRoute:
      return CustomMaterialPageRoute(builder: (context) => LoadingUI());
    case kprSettingsRoute:
      return CustomMaterialPageRoute(builder: (context) => SettingsUI());
    case kprThemesRoute:
      return CustomMaterialPageRoute(builder: (context) => ThemesUI());
    case kprNewGameRoute:
      return CustomMaterialPageRoute(
        builder: (context) => BlocProvider<LevelSettingsBloc>(
          create: (context) => LevelSettingsBloc(
              repository: LevelSettingsSqliteRepository()),
          child: NewGameUI(),
        ),
      );

    default:
      throw Exception("Route name was not found.");
  }
};

class CustomMaterialPageRoute extends MaterialPageRoute {
  final Duration transitionDuration;
  CustomMaterialPageRoute(
      {required builder,
      this.transitionDuration = const Duration(milliseconds: 700)})
      : super(builder: builder);

  Animation? curved;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (curved == null)
      curved = CurvedAnimation(curve: Curves.ease, parent: animation);
    return Transform.translate(
      offset: Offset(0.0, (1 - curved!.value) * -100),
      child: Opacity(opacity: curved!.value, child: child),
    );
  }
}
