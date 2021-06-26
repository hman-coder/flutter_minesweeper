import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/bloc/audio_manager.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme_bloc.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
import 'package:provider/provider.dart';
import 'package:minesweeper_flutter/helpers/math.dart';
import 'package:minesweeper_flutter/presentation/animations/rocking_animation.dart';
import 'package:minesweeper_flutter/presentation/widgets/constant_widgets.dart';
import 'package:minesweeper_flutter/presentation/widgets/delayed_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/mine_icon_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/spacers.dart';
import 'package:minesweeper_flutter/repository/sqlite_accessor.dart';
import 'package:minesweeper_flutter/helpers/context_extensions.dart';

class MainMenuUI extends StatelessWidget {
  final double bottomMineSize;

  /// A little portion of the mine is always hidden.
  final double hiddenPortionOfMine;

  static const double appBarHeight = 70;

  /// A bottom margin for the main components of the ui (buttons) such that
  /// they won't be overimposed on the bottom big mine
  final double bottomMarginOfContents;

  const MainMenuUI({
    Key? key,
    this.bottomMineSize = 450,
  })  : hiddenPortionOfMine = bottomMineSize * 0.4,
        bottomMarginOfContents = bottomMineSize * 0.6,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization().minesweeper),
        toolbarHeight: appBarHeight,
        actions: [_buildDeleteTableButton()],
      ),
      extendBodyBehindAppBar: true,
      body: DelayedWidgetsController(
        overallDelay: Duration(milliseconds: 600),
        weights: [5, 2, 2],
        child: Stack(
          children: [
            _buildBottomMine(context),
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomMarginOfContents,
              top: appBarHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kwEmptyExpanded,
                  _buildNewGameButton(context),
                  kwEnormousVerticalSpacer,
                  _buildThemesButton(context),
                  kwEnormousVerticalSpacer,
                  _buildSettingsButton(context),
                  kwEmptyExpanded,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteTableButton() {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async => (await SqliteAccessor.accessor).deleteDb(),
    );
  }

  Widget _buildNewGameButton(BuildContext context) {
    return DelayedWidget(
      rank: 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.decelerate,
      builder: defaultDelayedTransition,
      child: OutlinedButton(
        onPressed: () {
          AudioManager().normalClick();
          Navigator.of(context).pushNamed(kprNewGameRoute);
        },
        child: Text(context.localization().newGame),
      ),
    );
  }

  Widget _buildThemesButton(BuildContext context) {
    return DelayedWidget(
      rank: 2,
      builder: defaultDelayedTransition,
      duration: Duration(milliseconds: 500),
      child: TextButton.icon(
        icon: Icon(Icons.brush),
        label: Text(context.localization().theme),
        onPressed: () {
          AudioManager().normalClick();
          Navigator.of(context).pushNamed(kprThemesRoute);
        },
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return DelayedWidget(
      rank: 3,
      duration: Duration(milliseconds: 500),
      curve: Curves.decelerate,
      builder: defaultDelayedTransition,
      child: TextButton.icon(
        onPressed: () {
          AudioManager().normalClick();
          Navigator.of(context).pushNamed(kprSettingsRoute);
        },
        label: Text(context.localization().settings),
        icon: Icon(Icons.settings),
      ),
    );
  }

  Widget _buildBottomMine(BuildContext context) {
    return Positioned(
      left: -1 * hiddenPortionOfMine,
      bottom: -1 * hiddenPortionOfMine,
      child: Hero(
        tag: "mine",
        child: RockingAnimation(
          startingAnimationValue: 0.5,
          endingRadians: MathHelper.degreesToRadians(-40),
          startingRadians: MathHelper.degreesToRadians(40),
          child: MineIcon(
            color: context.watch<MinesweeperThemeBloc>().state.mineColor.withOpacity(0.5),
            size: 450,
          ),
        ),
      ),
    );
  }
}
