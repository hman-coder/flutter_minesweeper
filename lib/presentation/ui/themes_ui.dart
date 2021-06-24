import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/bloc/minesweeper_theme/minesweeper_theme_bloc.dart';
import 'package:minesweeper_flutter/helpers/math.dart';
import 'package:minesweeper_flutter/presentation/animations/rocking_animation.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/presentation/widgets/spacers.dart';

class ThemesUI extends StatelessWidget {
  const ThemesUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ThemeModifier(
          color: context.watch<MinesweeperThemeBloc>().state.mineColor,
          icon: context.watch<MinesweeperThemeBloc>().state.mineIcon,
          onColorChanged: context.read<MinesweeperThemeBloc>().changeMineColor,
          onIconChanged: context.read<MinesweeperThemeBloc>().changeMineIcon,
        ),
      )),
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

  const ThemeModifier({
    Key? key,
    required this.color,
    required this.onColorChanged,
    required this.icon,
    required this.onIconChanged,
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
        values: [Colors.black, Colors.red, Colors.purple],
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
          values: [MinesweeperIcons.mine, MinesweeperIcons.mine_relaxed]),
    );
  }
}

class Spinner<T> extends StatefulWidget {
  final List<T> values;

  final Widget Function(T) itemBuilder;

  final Function(T) onValueChanged;

  final T value;

  const Spinner({
    Key? key,
    required this.values,
    required this.itemBuilder,
    required this.onValueChanged,
    required this.value,
  }) : super(key: key);

  @override
  _SpinnerState<T> createState() => _SpinnerState<T>();
}

class _SpinnerState<T> extends State<Spinner<T>> {
  late FixedExtentScrollController scrollController;

  @override
  void initState() {
    int initialItemIndex = widget.values.indexOf(widget.value);
    scrollController =
        FixedExtentScrollController(initialItem: initialItemIndex);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _animateTo(int index) {
    scrollController.animateToItem(index,
        duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLeftArrow(),
        Expanded(child: _buildCurrentItem()),
        _buildRightArrow(),
      ],
    );
  }

  Widget _buildLeftArrow() {
    return IconButton(
      onPressed: () => _animateTo(scrollController.selectedItem - 1),
      icon: Icon(Icons.arrow_back),
    );
  }

  Widget _buildRightArrow() {
    return IconButton(
      onPressed: () => _animateTo(scrollController.selectedItem + 1),
      icon: Icon(Icons.arrow_forward),
    );
  }

  Widget _buildCurrentItem() {
    return RotatedBox(
      quarterTurns: 3,
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: (index) =>
            widget.onValueChanged(widget.values[(index)]),
        diameterRatio: 1.5,
        overAndUnderCenterOpacity: 0.5,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: widget.values
              .map<Widget>(
                (e) => RotatedBox(
                  quarterTurns: 1,
                  child: Center(
                    child: widget.itemBuilder(e),
                  ),
                ),
              )
              .toList(),
        ),
        itemExtent: 60,
        controller: scrollController,
        physics: FixedExtentScrollPhysics(),
      ),
    );
  }
}
