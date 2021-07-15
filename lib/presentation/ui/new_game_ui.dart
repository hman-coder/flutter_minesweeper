import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:minesweeper_flutter/bloc/audio_manager.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme/minesweeper_theme_bloc.dart';
import 'package:minesweeper_flutter/helpers/context_extensions.dart';
import 'package:minesweeper_flutter/helpers/math.dart';
import 'package:minesweeper_flutter/model/minesweeper_level_settings.dart';
import 'package:minesweeper_flutter/presentation/animations/rocking_animation.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/presentation/widgets/enabled_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/mine_icon_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/fill_size_button.dart';
import 'package:minesweeper_flutter/presentation/widgets/spacers.dart';
import 'package:minesweeper_flutter/presentation/widgets/spinner.dart';
import 'package:minesweeper_flutter/presentation/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The duration after which elements that are not related to the selected mode
/// disapper.
const Duration _kdShowOrHideWidgetsDuration = Duration(milliseconds: 300);

const double _kdBottomPlayButtonHeight = 70;

class NewGameUI extends StatefulWidget {
  const NewGameUI({Key? key}) : super(key: key);

  @override
  _NewGameUIState createState() => _NewGameUIState();
}

class _NewGameUIState extends State<NewGameUI> with TickerProviderStateMixin {
  GameDifficulty difficulty = GameDifficulty.intermediate;

  GameMode gameMode = GameMode.standard;

  void _changeGameMode(GameMode mode) {
    if (this.gameMode == mode) return;
    this.gameMode = mode;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization().newGame),
        ),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Positioned(child: _buildBackgroundMine()),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: _kdBottomPlayButtonHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _GameModePicker(
                        onGameModeChanged: (mode) =>
                            setState(() => this._changeGameMode(mode)),
                        selectedGameMode: this.gameMode),
                    _GameModeDescriptionCard(gameMode: gameMode),
                    _DifficultyPicker(
                      gameMode: gameMode,
                      currentDifficulty: this.difficulty,
                      onDifficultyChanged: (difficulty) =>
                          setState(() => this.difficulty = difficulty),
                    ),
                    _DifficultyDetailsCard(
                      currentGameMode: gameMode,
                      difficulty: difficulty,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              height: _kdBottomPlayButtonHeight,
              child: _buildPlayButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundMine() {
    return Hero(
      tag: "mine",
      child: RockingAnimation(
        startingAnimationValue: 0.5,
        endingRadians: MathHelper.degreesToRadians(-40),
        startingRadians: MathHelper.degreesToRadians(40),
        child: MineIcon(
          opacity: 0.4,
          size: 450,
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return FillSizeButton(
      onPressed: () => print("play"),
      child: TextWidget(
        data: "Play",
        type: TextWidgetType.headline6,
        color: context.watch<MinesweeperThemeBloc>().currentTheme.isDarkTheme ? Colors.black : Colors.white,
      ),
    );
  }
}

/// A card through which players can pick between different [GameMode]s
class _GameModePicker extends StatelessWidget {
  final Function(GameMode) onGameModeChanged;

  final GameMode selectedGameMode;

  const _GameModePicker(
      {Key? key,
      required this.onGameModeChanged,
      required this.selectedGameMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextWidget(
              data:
                  "${context.localization().gameMode}: ${selectedGameMode.toAppString(context)}",
              type: TextWidgetType.subtitle1,
            ),
            kwEnormousVerticalSpacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _GameModeButton(
                  groupValue: this.selectedGameMode,
                  value: GameMode.endless,
                  icon: MinesweeperIcons.infinity,
                  onTap: (value) {
                    AudioManager().normalClick();
                    onGameModeChanged(GameMode.endless);
                  },
                ),
                kwMediumHorizontalSpacer,
                _GameModeButton(
                  groupValue: this.selectedGameMode,
                  value: GameMode.standard,
                  icon: MinesweeperIcons.standard,
                  onTap: (value) {
                    AudioManager().normalClick();
                    onGameModeChanged(GameMode.standard);
                  },
                ),
                kwMediumHorizontalSpacer,
                _GameModeButton(
                  groupValue: this.selectedGameMode,
                  value: GameMode.run,
                  icon: MinesweeperIcons.run,
                  onTap: (value) {
                    AudioManager().normalClick();
                    onGameModeChanged(GameMode.run);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The radio button that appears in a [_GameModePicker] instance.
class _GameModeButton extends StatelessWidget {
  final GameMode value;

  final GameMode groupValue;

  final NeumorphicRadioListener<GameMode?> onTap;

  final IconData icon;

  const _GameModeButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicRadio<GameMode>(
      padding: EdgeInsets.all(10),
      duration: Duration(milliseconds: 300),
      onChanged: this.onTap,
      child: Center(
        child: Icon(
          icon,
          size: 50,
        ),
      ),
      value: value,
      groupValue: groupValue,
    );
  }
}

class _GameModeDescriptionCard extends StatelessWidget {
  final GameMode gameMode;

  const _GameModeDescriptionCard({Key? key, required this.gameMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color collapseColor =
        context.watch<MinesweeperThemeBloc>().currentTheme.isDarkTheme
            ? Colors.white
            : Colors.black;
    return Card(
      child: ListTileTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ExpansionTile(
          collapsedIconColor: collapseColor,
          collapsedTextColor: collapseColor,
          initiallyExpanded: true,
          childrenPadding: EdgeInsets.all(20),
          title: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Text(
              gameMode.descriptionTitle(context),
              textAlign: TextAlign.start,
              key: ValueKey(gameMode),
            ),
            transitionBuilder: (child, animation) => FadeTransition(
              child: child,
              opacity: animation,
            ),
          ),
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Text(
                gameMode.description(context),
                key: ValueKey(gameMode.toAppString(context)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// A [Card] containing a [Text] as a title and a [Spinner] as body.
/// This widgets allows the user to pick difficulties.
/// This widget will hide/show itself based on the [gameMode] parameter.
class _DifficultyPicker extends StatefulWidget {
  final Function(GameDifficulty) onDifficultyChanged;

  final GameDifficulty currentDifficulty;

  final GameMode gameMode;

  const _DifficultyPicker(
      {Key? key,
      required this.gameMode,
      required this.currentDifficulty,
      required this.onDifficultyChanged})
      : super(key: key);

  @override
  _DifficultyPickerState createState() => _DifficultyPickerState();
}

const double _kdDifficultyPickerMaxHeight = 250;
const double _kdDifficultlySpinnerHeight = 70;
const double _kdDifficultyItemWidth = 100;

class _DifficultyPickerState extends State<_DifficultyPicker>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  // late List<GameDifficulty> gameDifficulties;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: _kdShowOrHideWidgetsDuration);
    if (_shouldBeVisible) controller.value = 1;
    controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _DifficultyPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gameMode != this.widget.gameMode)
      _showOrHideWidgetBasedOnMode();
  }

  _showOrHideWidgetBasedOnMode() {
    if (_shouldBeVisible)
      controller.forward();
    else
      controller.reverse();
  }

  bool get _shouldBeVisible => widget.gameMode.difficulties.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: _kdDifficultyPickerMaxHeight * controller.value,
        minHeight: 0,
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TextWidget(
                  type: TextWidgetType.subtitle1,
                  data: context.localization().difficulty,
                ),
              ),
              SizedBox(
                height: _kdDifficultlySpinnerHeight * controller.value,
                child: Spinner<GameDifficulty>(
                  itemWidth: _kdDifficultyItemWidth,
                  values: widget.gameMode.difficulties,
                  itemBuilder: (difficulty) =>
                      Text(difficulty.toAppString(context)),
                  onValueChanged: this.widget.onDifficultyChanged,
                  value: this.widget.currentDifficulty,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A card that has all the details of a specific difficulty.
/// Currently, this is only useful for when the mode is [GameMode.standard], as the user
/// can specify/see the number of mines and number of tiles in both horizontal and vertical directions.
/// This widget hides/shows itself base on the selected [GameMode].
class _DifficultyDetailsCard extends StatefulWidget {
  final GameDifficulty difficulty;

  final GameMode currentGameMode;

  const _DifficultyDetailsCard(
      {Key? key, required this.difficulty, required this.currentGameMode})
      : super(key: key);

  @override
  _DifficultyDetailsCardState createState() => _DifficultyDetailsCardState();
}

class _DifficultyDetailsCardState extends State<_DifficultyDetailsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: _kdShowOrHideWidgetsDuration);
    if (_shouldBeVisible) controller.value = 1;
    controller.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(covariant _DifficultyDetailsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this.widget.currentGameMode != oldWidget.currentGameMode)
      _showOrHideWidgetBasedOnMode();
  }

  _showOrHideWidgetBasedOnMode() {
    if (_shouldBeVisible)
      controller.forward();
    else
      controller.reverse();
  }

  bool get _shouldBeVisible =>
      [GameMode.standard].contains(widget.currentGameMode);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: controller.value * 190),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                    child: _DifficultyDetail(
                  enabled: widget.difficulty == GameDifficulty.custom,
                  tooltipMessage: context.localization().mines,
                  icon: MineIcon(size: 40),
                  initialValue: widget.difficulty.mines,
                  onValueChanged: (value) => print(value),
                )),
              ),
              Expanded(
                child: Center(
                  child: _DifficultyDetail(
                    enabled: widget.difficulty == GameDifficulty.custom,
                    tooltipMessage: context.localization().height,
                    icon: Icon(Icons.expand, size: 40),
                    initialValue: widget.difficulty.height,
                    onValueChanged: (value) => print(value),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: _DifficultyDetail(
                    enabled: widget.difficulty == GameDifficulty.custom,
                    tooltipMessage: context.localization().width,
                    icon: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(Icons.expand, size: 40),
                    ),
                    initialValue: widget.difficulty.width,
                    onValueChanged: (value) => print(value),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DifficultyDetail extends StatelessWidget {
  final int initialValue;

  final ValueChanged<int> onValueChanged;

  final Widget icon;

  final String tooltipMessage;

  final bool enabled;

  const _DifficultyDetail({
    Key? key,
    required this.initialValue,
    required this.onValueChanged,
    required this.icon,
    required this.tooltipMessage,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: this.tooltipMessage,
            preferBelow: true,
            child: this.icon,
          ),
          kwLargeVerticalSpacer,
          EnabledWidget(
            enabled: enabled,
            child: TextField(
              enabled: this.enabled,
              controller: TextEditingController(text: initialValue.toString()),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              maxLength: 3,
              buildCounter: (context,
                      {currentLength = 1, isFocused = true, maxLength}) =>
                  Container(),
              textAlign: TextAlign.center,
              onChanged: (text) => onValueChanged(int.parse(text)),
            ),
          )
        ],
      ),
    );
  }
}
