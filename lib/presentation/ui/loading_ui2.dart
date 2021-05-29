import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';

class LoadingUI extends StatefulWidget {
  @override
  _LoadingUIState createState() => _LoadingUIState();
}

class _LoadingUIState extends State<LoadingUI> with TickerProviderStateMixin {
  late AnimationController controller;

  late AnimationController flashController;

  static const double _mineSize = 150;

  @override
  initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) controller.reverse();

      if (controller.status == AnimationStatus.dismissed) controller.forward();
    });
    controller.forward();

    flashController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    flashController.addListener(() {
      if (flashController.status == AnimationStatus.completed)
        flashController.reverse();

      if (flashController.status == AnimationStatus.dismissed)
        flashController.forward();
    });
    flashController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
      animation: controller,
      builder: (_, child) => ClipRect(
        clipper: Clip(controller.value, TextDirection.ltr),
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
              animation: controller,
              builder: (_, child) => ClipRect(
                clipper: Clip(controller.value, TextDirection.rtl),
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
              animation: controller,
              builder: (_, child) => Transform.translate(
                  offset: Offset(
                      (controller.value * _mineSize) - (_mineSize / 2), 0),
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

class Clip extends CustomClipper<Rect> {
  Clip(this.percentageWidthToHide, this.direction);

  double percentageWidthToHide;

  TextDirection direction;

  @override
  Rect getClip(Size size) {
    bool ltr = direction == TextDirection.ltr;
    double width = getClipWidth(size.width);
    Rect rect = Rect.fromLTRB(
      ltr ? 0 : width,
      0,
      ltr ? width : size.width,
      size.height,
    );
    return rect;
  }

  double getClipWidth(double originalWidth) =>
      originalWidth * percentageWidthToHide;

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
