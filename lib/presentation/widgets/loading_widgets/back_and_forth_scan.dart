import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/presentation/widgets/horizontal_percentage_clipper.dart';

/// A loading animation that shows a red bar going back and forth as it scans a mine
class BackAndForthScan extends StatefulWidget {
  @override
  _BackAndForthScanState createState() => _BackAndForthScanState();
}

class _BackAndForthScanState extends State<BackAndForthScan>
    with TickerProviderStateMixin {

  late AnimationController scanBarMotionController;

  late AnimationController flashController;

  late AnimationController sizeController;

  late Animation<double> sizeAnimation;

  static const double _mineSize = 150;

  @override
  initState() {
    _initScanBarAnimation();
    _initSizeAnimation();
    _initFlashAnimation();
    super.initState();
  }

  /// Initializes components responsible for moving the scan bar
  void _initScanBarAnimation() {
    scanBarMotionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    scanBarMotionController.addListener(() {
      if (scanBarMotionController.status == AnimationStatus.completed)
        scanBarMotionController.reverse();

      if (scanBarMotionController.status == AnimationStatus.dismissed)
        scanBarMotionController.forward();
    });
    scanBarMotionController.forward();
  }

  /// Initializes componeonts responsible for manipulating the size of the whole widget.
  void _initSizeAnimation() {
    this.sizeController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    this.sizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.8), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.8, end: 1), weight: 1),
    ]).animate(
      sizeController,
    );
    sizeController.repeat();
  }

  /// Initializes the components responsible for making the scan bar flash.
  void _initFlashAnimation() {
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: flashController,
        builder: (_, child) => Transform.scale(
          scale: sizeAnimation.value,
          child: child,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildMine(),
            _buildFlag(),
            _buildScanBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildMine() {
    return AnimatedBuilder(
      animation: scanBarMotionController,
      builder: (_, child) => ClipRect(
        clipper: HorizontalPercentageClipper(
          scanBarMotionController.value,
          TextDirection.ltr,
        ),
        child: child,
      ),
      child: Icon(
        MinesweeperIcons.mine,
        size: _mineSize,
      ),
    );
  }

  Widget _buildFlag() {
    return AnimatedBuilder(
      animation: scanBarMotionController,
      builder: (_, child) => ClipRect(
        clipper: HorizontalPercentageClipper(
          scanBarMotionController.value,
          TextDirection.rtl,
        ),
        child: child,
      ),
      child: Transform.translate(
        offset: Offset(10, 0),
        child: Icon(
          MinesweeperIcons.flag,
          size: _mineSize,
          color: Colors.amber,
        ),
      ),
    );
  }

  Widget _buildScanBar() {
    return AnimatedBuilder(
      animation: scanBarMotionController,
      builder: (_, child) => Transform.translate(
          offset: Offset(
              (scanBarMotionController.value * _mineSize) - (_mineSize / 2), 0),
          child: child),
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
}
