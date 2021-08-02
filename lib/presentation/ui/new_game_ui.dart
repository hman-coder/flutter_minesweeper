import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:minesweeper_flutter/bloc/audio_manager.dart';
import 'package:minesweeper_flutter/helpers/context_extensions.dart';
import 'package:minesweeper_flutter/helpers/math.dart';
import 'package:minesweeper_flutter/model/level_settings.dart';
import 'package:minesweeper_flutter/presentation/animations/rocking_animation.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/presentation/widgets/enabled_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/mine_icon_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/fill_size_button.dart';
import 'package:minesweeper_flutter/presentation/widgets/spacers.dart';
import 'package:minesweeper_flutter/presentation/widgets/spinner.dart';
import 'package:minesweeper_flutter/presentation/widgets/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/game_theme/game_theme_bloc.dart';

import 'package:minesweeper_flutter/bloc/level_settings.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization().newGame),
        ),
        body: BlocBuilder<LevelSettingsBloc, LevelSettingsState>(
          buildWhen: (prev, cur) =>
              cur is InitialState || cur is SettingsUpdatedState,
          builder: (_, state) {
            bool blocInitialized = state is SettingsUpdatedState;
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Positioned(child: _buildBackgroundMine()),
                ! blocInitialized ? Center(child: CircularProgressIndicator()) : Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: _kdBottomPlayButtonHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _GameModePicker(),
                        _GameModeDescriptionCard(),
                        _DifficultyPicker(),
                        _DifficultyDetailsCard(),
                      ],
                    ),
                  ),
                ),
                ! blocInitialized ? const SizedBox() : Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  height: _kdBottomPlayButtonHeight,
                  child: _buildPlayButton(),
                ),
              ],
            );
          },
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
        color: context.watch<GameThemeBloc>().currentTheme.isDarkTheme
            ? Colors.black
            : Colors.white,
      ),
    );
  }
}

/// A card through which players can pick between different [GameMode]s
class _GameModePicker extends StatelessWidget {
  const _GameModePicker({
    Key? key,
  }) : super(key: key);

  bool _buildWhen(prev, cur) =>
      cur is SettingsUpdatedState || cur is GameModeUpdatedState;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            BlocBuilder<LevelSettingsBloc, LevelSettingsState>(
              buildWhen: _buildWhen,
              builder: (context, state) => TextWidget(
                data:
                    "${context.localization().gameMode}: ${context.read<LevelSettingsBloc>().currentSettings.mode.toAppString(context)}",
                type: TextWidgetType.subtitle1,
              ),
            ),
            kwEnormousVerticalSpacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _GameModeButton(
                  value: GameMode.endless,
                  icon: MinesweeperIcons.infinity,
                ),
                kwMediumHorizontalSpacer,
                _GameModeButton(
                  value: GameMode.standard,
                  icon: MinesweeperIcons.standard,
                ),
                kwMediumHorizontalSpacer,
                _GameModeButton(
                  value: GameMode.run,
                  icon: MinesweeperIcons.run,
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
/// Requires an instance of [LevelSettingsBloc] as an ancestor in the
/// widget tree.
class _GameModeButton extends StatelessWidget {
  final GameMode value;

  final IconData icon;

  const _GameModeButton({
    Key? key,
    required this.value,
    required this.icon,
  }) : super(key: key);

  bool _buildWhen(prev, cur) =>
      cur is GameModeUpdatedState || cur is SettingsUpdatedState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelSettingsBloc, LevelSettingsState>(
        buildWhen: _buildWhen,
        builder: (_, state) {
          var bloc = context.read<LevelSettingsBloc>();
          return NeumorphicRadio<GameMode>(
            padding: EdgeInsets.all(10),
            duration: Duration(milliseconds: 300),
            onChanged: (mode) {
              bloc.add(GameModeChangedEvent(this.value));
              AudioManager().normalClick();
            },
            child: Center(
              child: Icon(
                icon,
                size: 50,
              ),
            ),
            value: value,
            groupValue: bloc.currentSettings.mode,
          );
        });
  }
}

class _GameModeDescriptionCard extends StatelessWidget {
  bool _buildWhen(prev, cur) =>
      cur is SettingsUpdatedState || cur is GameModeUpdatedState;

  @override
  Widget build(BuildContext context) {
    Color collapseColor =
        context.watch<GameThemeBloc>().currentTheme.isDarkTheme
            ? Colors.white
            : Colors.black;
    return BlocBuilder<LevelSettingsBloc, LevelSettingsState>(
      buildWhen: _buildWhen,
      builder: (ctx, state) {
        var gameMode = ctx.read<LevelSettingsBloc>().currentSettings.mode;
        return Card(
          child: ListTileTheme(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
      },
    );
  }
}

/// A [Card] containing a [Text] as a title and a [Spinner] as body.
/// This widgets allows the user to pick difficulties.
/// This widget will hide/show itself based on the [LevelSettingsBloc] state.
class _DifficultyPicker extends StatefulWidget {
  @override
  _DifficultyPickerState createState() => _DifficultyPickerState();
}

const double _kdDifficultyPickerMaxHeight = 250;
const double _kdDifficultlySpinnerHeight = 70;
const double _kdDifficultyItemWidth = 100;

class _DifficultyPickerState extends State<_DifficultyPicker>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: _kdShowOrHideWidgetsDuration);
    controller.addListener(() => setState(() {}));
    _onModeUpdated(context.read<LevelSettingsBloc>().currentSettings.mode);
  }

  _onModeUpdated(GameMode mode) {
    if (_modeHasDifficulties(mode))
      _show();
    else
      _hide();
  }

  _show() => controller.forward();

  _hide() => controller.reverse();

  bool _modeHasDifficulties(GameMode mode) => mode.difficulties.isNotEmpty;

  bool _buildWhen(prev, cur) =>
      cur is InitialState ||
      cur is SettingsUpdatedState ||
      cur is GameModeUpdatedState;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LevelSettingsBloc, LevelSettingsState>(
      buildWhen: _buildWhen,
      listenWhen: _buildWhen,
      listener: (ctx, state) =>
          _onModeUpdated(ctx.read<LevelSettingsBloc>().currentSettings.mode),
      builder: (ctx, state) {
        print("rebuilding for state $state");
        var settings = ctx.read<LevelSettingsBloc>().currentSettings;
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
                      values: settings.mode.difficulties,
                      itemBuilder: (difficulty) =>
                          Text(difficulty.toAppString(context)),
                      onValueChanged: (value) => ctx
                          .read<LevelSettingsBloc>()
                          .add(DifficultyChangedEvent(value)),
                      value: settings.difficulty,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A card that has all the details of a specific difficulty.
/// Currently, this is only useful for when the mode is [GameMode.standard], as the user
/// can specify/see the number of mines and number of tiles in both horizontal and vertical directions.
/// This widget hides/shows itself base on the selected [GameMode].
class _DifficultyDetailsCard extends StatefulWidget {
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
    controller.addListener(() => setState(() {}));
  }

  _onModeUpdated(GameMode mode) {
    if (_modeHasDifficulties(mode))
      _show();
    else
      _hide();
  }

  _show() => controller.forward();

  _hide() => controller.reverse();

  bool _modeHasDifficulties(GameMode mode) =>
      [GameMode.standard].contains(mode);

  bool _buildWhen(prev, cur) =>
      cur is GameModeUpdatedState ||
      cur is SettingsUpdatedState ||
      cur is DifficultyUpdatedState;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LevelSettingsBloc, LevelSettingsState>(
        buildWhen: _buildWhen,
        listener: (context, _) => _onModeUpdated(
            context.read<LevelSettingsBloc>().currentSettings.mode),
        builder: (context, _) {
          var bloc = context.read<LevelSettingsBloc>();
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
                          enabled: bloc.currentSettings.difficulty ==
                              GameDifficulty.custom,
                          tooltipMessage: context.localization().mines,
                          icon: MineIcon(size: 40),
                          initialValue: bloc.currentSettings.difficulty.mines,
                          onValueChanged: (value) => print(value),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: _DifficultyDetail(
                          enabled: bloc.currentSettings.difficulty ==
                              GameDifficulty.custom,
                          tooltipMessage: context.localization().height,
                          icon: Icon(Icons.expand, size: 40),
                          initialValue: bloc.currentSettings.difficulty.height,
                          onValueChanged: (value) => print(value),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: _DifficultyDetail(
                          enabled: bloc.currentSettings.difficulty ==
                              GameDifficulty.custom,
                          tooltipMessage: context.localization().width,
                          icon: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(Icons.expand, size: 40),
                          ),
                          initialValue: bloc.currentSettings.difficulty.width,
                          onValueChanged: (value) => print(value),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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
