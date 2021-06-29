import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme.dart';
import 'package:minesweeper_flutter/bloc/unlocked_features_bloc.dart';
import 'package:minesweeper_flutter/helpers/math.dart';
import 'package:minesweeper_flutter/presentation/animations/rocking_animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/presentation/widgets/color_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/spacers.dart';
import 'package:minesweeper_flutter/presentation/widgets/spinner.dart';
import 'package:minesweeper_flutter/presentation/widgets/text_widget.dart';
import 'package:minesweeper_flutter/helpers/context_extensions.dart';

class ThemesUI extends StatelessWidget {
  const ThemesUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextWidget(
        data: context.localization().theme,
        type: TextWidgetType.headline6,
      )),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              kwEnormousVerticalSpacer,
              TextWidget(
                type: TextWidgetType.subtitle1,
                data: context.localization().backgroundColor,
              ),
              kwMediumVerticalSpacer,
              _buildBackgroundModifier(context),
              kwEnormousVerticalSpacer,
              _buildMineModifier(context),
              kwEnormousVerticalSpacer,
              _buildFlagModifier(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundModifier(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BlocBuilder<MinesweeperThemeBloc, MinesweeperThemeState>(
          buildWhen: (prev, cur) =>
              cur is BackgroundColorUpdatedState || cur is InitialState || cur is ThemeReloadedState,
          builder: (context, state) {
            var color = context.read<MinesweeperThemeBloc>().currentTheme.backgroundColor;
            return Spinner<Color>(
              values:
                  context.watch<UnlockedFeaturesBloc>().state.backgroundColors,
              itemBuilder: (item) => ColorWidget(item),
              onValueChanged: (value) => context
                  .read<MinesweeperThemeBloc>()
                  .add(BackgroundColorChangeEvent(value)),
              value: color,
            );
          }),
    );
  }

  Widget _buildMineModifier(BuildContext context) {
    return BlocBuilder<MinesweeperThemeBloc, MinesweeperThemeState>(
        buildWhen: (prev, cur) => cur is MineThemeUpdatedState || cur is InitialState || cur is ThemeReloadedState,
        builder: (context, state) {
          var mineTheme = context.read<MinesweeperThemeBloc>().currentTheme.mineTheme;

          return ThemeModifier(
            title: TextWidget(
              data: context.localization().mineAppearance,
              type: TextWidgetType.subtitle1,
            ),
            color: mineTheme.color,
            icon: mineTheme.icon,
            onColorChanged: (color) => context
                .read<MinesweeperThemeBloc>()
                .add(MineThemeChangeEvent(color: color)),
            onIconChanged: (icon) => context
                .read<MinesweeperThemeBloc>()
                .add(MineThemeChangeEvent(icon: icon)),
            colors: context.watch<UnlockedFeaturesBloc>().state.mineColors,
            icons: context.watch<UnlockedFeaturesBloc>().state.mineIcons,
          );
        });
  }

  Widget _buildFlagModifier(BuildContext context) {
    return BlocBuilder<MinesweeperThemeBloc, MinesweeperThemeState>(
      buildWhen: (prev, cur) => cur is FlagThemeUpdatedState || cur is InitialState || cur is ThemeReloadedState,
      builder: (context, state) {
        var flagTheme = context.read<MinesweeperThemeBloc>().currentTheme.flagTheme;
        return ThemeModifier(
          title: TextWidget(
            data: context.localization().flagAppearance,
            type: TextWidgetType.subtitle1,
          ),
          color: flagTheme.color,
          icon: flagTheme.icon,
          onColorChanged: (color) => context
              .read<MinesweeperThemeBloc>()
              .add(FlagThemeChangeEvent(color: color)),
          onIconChanged: (icon) => context
              .read<MinesweeperThemeBloc>()
              .add(FlagThemeChangeEvent(icon: icon)),
          colors: context.watch<UnlockedFeaturesBloc>().state.flagColors,
          icons: context.watch<UnlockedFeaturesBloc>().state.flagIcons,
        );
      },
    );
  }
}

class ThemeModifier extends StatelessWidget {
  final Color color;

  final Function(Color) onColorChanged;

  final IconData icon;

  final Function(IconData) onIconChanged;

  final double? width;

  final double? height;

  final Widget? title;

  final List<Color> colors;

  final List<IconData> icons;

  const ThemeModifier({
    Key? key,
    required this.color,
    required this.onColorChanged,
    required this.icon,
    required this.onIconChanged,
    required this.icons,
    required this.colors,
    this.title,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) title!,
          if (title != null) kwLargeVerticalSpacer,
          _buildPreviewWidget(),
          kwMediumVerticalSpacer,
          _buildColorSpinner(),
          kwMediumVerticalSpacer,
          _buildIconSpinner(),
        ],
      ),
    );
  }

  Widget _buildPreviewWidget() {
    return RockingAnimation(
      startingAnimationValue: Random(DateTime.now().millisecond).nextDouble(),
      endingRadians: MathHelper.degreesToRadians(-35),
      startingRadians: MathHelper.degreesToRadians(50),
      child: Icon(
        icon,
        color: color,
        size: 70,
      ),
    );
  }

  Widget _buildColorSpinner() {
    return SizedBox(
      height: 70,
      child: Spinner<Color>(
        itemBuilder: (color) => ColorWidget(color),
        onValueChanged: onColorChanged,
        value: color,
        values: colors,
      ),
    );
  }

  Widget _buildIconSpinner() {
    return SizedBox(
      height: 70,
      child: Spinner<IconData>(
          itemBuilder: (item) => Icon(item, size: 35),
          onValueChanged: onIconChanged,
          value: icon,
          values: icons),
    );
  }
}
