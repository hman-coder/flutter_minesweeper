import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme_bloc.dart';
import 'package:minesweeper_flutter/bloc/unlocked_features_bloc.dart';
import 'package:minesweeper_flutter/helpers/math.dart';
import 'package:minesweeper_flutter/presentation/animations/rocking_animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/presentation/widgets/spacers.dart';
import 'package:minesweeper_flutter/presentation/widgets/spinner.dart';
import 'package:minesweeper_flutter/presentation/widgets/text_widget.dart';

class ThemesUI extends StatelessWidget {
  const ThemesUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextWidget(data: "Themes", type: TextWidgetType.headline6,)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              kwEnormousVerticalSpacer,
              TextWidget(
                type: TextWidgetType.subtitle1,
                data: "Background Color",
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
      child: Spinner<Color>(
        values: context.watch<UnlockedFeaturesBloc>().state.backgroundColors,
        itemBuilder: (element) => Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: element,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onValueChanged:
            context.read<MinesweeperThemeBloc>().changeBackgroundColor,
        value: context.watch<MinesweeperThemeBloc>().state.backgroundColor,
      ),
    );
  }

  Widget _buildMineModifier(BuildContext context) {
    return ThemeModifier(
      title: TextWidget(
        data: "Mine Appearance",
        type: TextWidgetType.subtitle1,
      ),
      color: context.watch<MinesweeperThemeBloc>().state.mineColor,
      icon: context.watch<MinesweeperThemeBloc>().state.mineIcon,
      onColorChanged: context.read<MinesweeperThemeBloc>().changeMineColor,
      onIconChanged: context.read<MinesweeperThemeBloc>().changeMineIcon,
      colors: context.watch<UnlockedFeaturesBloc>().state.mineColors,
      icons: context.watch<UnlockedFeaturesBloc>().state.mineIcons,
    );
  }

  Widget _buildFlagModifier(BuildContext context) {
    return ThemeModifier(
      title: TextWidget(
        data: "Flag Appearance",
        type: TextWidgetType.subtitle1,
      ),
      color: context.watch<MinesweeperThemeBloc>().state.flagColor,
      icon: context.watch<MinesweeperThemeBloc>().state.flagIcon,
      onColorChanged: context.read<MinesweeperThemeBloc>().changeFlagColor,
      onIconChanged: context.read<MinesweeperThemeBloc>().changeFlagIcon,
      colors: context.watch<UnlockedFeaturesBloc>().state.flagColors,
      icons: context.watch<UnlockedFeaturesBloc>().state.flagIcons,
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
        itemBuilder: (item) => Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: item,
          ),
        ),
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