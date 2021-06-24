import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/presentation/widgets/flag_icon_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/horizontal_percentage_clipper.dart';
import 'package:minesweeper_flutter/presentation/widgets/mine_icon_widget.dart';

class ScreenWidthScan extends StatefulWidget {
  @override
  _ScreenWidthScanState createState() => _ScreenWidthScanState();
}

class _ScreenWidthScanState extends State<ScreenWidthScan>
    with TickerProviderStateMixin {
  late AnimationController flashController;

  late AnimationController barMotionController;

  late Animation<double> switchableIconAnimation;

  static const double _mineSize = 150;

  @override
  initState() {
    _initFlashController();
    _initBarAnimations();
    super.initState();
  }

  void _initBarAnimations() {
    barMotionController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    barMotionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        switchWidgets();

        barMotionController.reset();
        barMotionController.forward();
      }
    });

    switchableIconAnimation =
        Tween(begin: -0.05, end: 1.05).animate(CurvedAnimation(
      parent: barMotionController,
      curve: Curves.fastOutSlowIn,
    ));

    barMotionController.forward();
  }

  void _initFlashController() {
    flashController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    flashController.addListener(() {
      if (flashController.status == AnimationStatus.completed)
        flashController.reverse();

      if (flashController.status == AnimationStatus.dismissed)
        flashController.forward();
    });
    flashController.forward();
  }

  double getRectValue(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var halfMineSize = (_mineSize / 2);
    var startingDistance = (screenWidth / 2) - halfMineSize;
    double startingValue = startingDistance / screenWidth;
    var endingDistance = (screenWidth / 2) + halfMineSize;
    double endingValue = endingDistance / screenWidth;

    var currentBarValue = switchableIconAnimation.value;
    if (currentBarValue < startingValue)
      return 0;
    else if (currentBarValue > endingValue)
      return 1;
    else {
      var fullValue = endingValue - startingValue;
      var currentValue = currentBarValue - startingValue;
      var x = currentValue / fullValue;

      return x;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Center(child: _buildMine(context)),
          Center(child: _buildFlag(context)),
          _buildScanBar(),
        ],
      ),
    );
  }

  Widget _currentWidget = FlagIcon(
    xOffset: 10,
    size: _mineSize,
  );

  Widget _nextWidget = MineIcon(size: _mineSize);

  void switchWidgets() {
    var temp = _currentWidget;
    _currentWidget = _nextWidget;
    _nextWidget = temp;
  }

  Widget _buildMine(BuildContext context) {
    return AnimatedBuilder(
      animation: switchableIconAnimation,
      builder: (_, child) => ClipRect(
        clipper: HorizontalPercentageClipper(
            getRectValue(context), TextDirection.ltr),
        child: _nextWidget,
      ),
      child: _nextWidget,
    );
  }

  Widget _buildFlag(BuildContext context) {
    return AnimatedBuilder(
      animation: switchableIconAnimation,
      builder: (_, child) => ClipRect(
        clipper: HorizontalPercentageClipper(
            getRectValue(context), TextDirection.rtl),
        child: _currentWidget,
      ),
    );
  }

  Widget _buildScanBar() {
    return AnimatedBuilder(
      animation: switchableIconAnimation,
      builder: (_, child) => Transform.translate(
          offset: Offset(_barPosition(context), 0), child: child),
      child: AnimatedBuilder(
        animation: flashController,
        builder: (_, __) => Container(
          height: _mineSize,
          width: 15,
          color: Colors.red.withOpacity(flashController.value),
        ),
      ),
    );
  }

  double _barPosition(BuildContext context) {
    // (controller.value * _mineSize) - (_mineSize / 2)
    double screenWidth = MediaQuery.of(context).size.width;
    double currentPosition = (switchableIconAnimation.value * screenWidth);
    return currentPosition;
  }
}
