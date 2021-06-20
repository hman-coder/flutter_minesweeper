import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/bloc/audio_manager.dart';
import 'package:minesweeper_flutter/helpers/math.dart';
import 'package:minesweeper_flutter/presentation/animations/rocking_animation.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/presentation/widgets/constant_widgets.dart';
import 'package:minesweeper_flutter/presentation/widgets/delayed_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/spacers.dart';

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
        title: Text("Minesweeper"),
        toolbarHeight: appBarHeight,
      ),
      extendBodyBehindAppBar: true,
      body: DelayedWidgetsController(
        overallDelay: Duration(milliseconds: 600),
        weights: [5, 2, 2],
        child: Stack(
          children: [
            _buildBottomMine(),
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
                  _buildNewGameButton(),
                  kwEnormousVerticalSpacer,
                  _buildThemesButton(),
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

  Widget _buildNewGameButton() {
    return DelayedWidget(
      rank: 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.decelerate,
      builder: defaultDelayedTransition,
      child: OutlinedButton(
        onPressed: () {
          AudioManager().normalClick();
        },
        child: Text("New Game"),
      ),
    );
  }

  Widget _buildThemesButton() {
    return DelayedWidget(
      rank: 2,
      builder: defaultDelayedTransition,
      duration: Duration(milliseconds: 500),
      child: TextButton.icon(
        icon: Icon(Icons.brush),
        label: Text("Theme"),
        onPressed: () => print("themes"),
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
          Navigator.of(context).pushNamed("/settings");
        },
        label: Text("Settings"),
        icon: Icon(Icons.settings),
      ),
    );
  }

  Widget _buildBottomMine() {
    return Positioned(
      left: -1 * hiddenPortionOfMine,
      bottom: -1 * hiddenPortionOfMine,
      child: Hero(
        tag: "mine",
        child: RockingAnimation(
          startingAnimationValue: 0.5,
          endingRadians: MathHelper.degreesToRadians(-40),
          startingRadians: MathHelper.degreesToRadians(40),
          child: Icon(
            MinesweeperIcons.mine,
            color: Colors.black.withOpacity(0.5),
            size: 450,
          ),
        ),
      ),
    );
  }
}
