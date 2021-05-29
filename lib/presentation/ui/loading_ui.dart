import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/helpers/math.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';

class LoadingUI extends StatefulWidget {
  @override
  _LoadingUIState createState() => _LoadingUIState();
}

class _LoadingUIState extends State<LoadingUI> with TickerProviderStateMixin {
  late AnimationController sizeController;

  late Animation sizeAnimation;

  late AnimationController rotationController;

  late Animation<double> rotationAnimation;

  late AnimationController flagController;

  late Animation<double> flagSizeAnimation;

  static const double _mineSize = 150;

  @override
  void initState() {
    this.flagController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    this.sizeController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    this.sizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.8), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.8, end: 1), weight: 1),
    ]).animate(
      sizeController,
    );

    this.rotationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    Animation<double> curvedRotationController =
        CurvedAnimation(parent: rotationController, curve: Curves.slowMiddle);

    rotationAnimation = Tween(
      begin: MathHelper.degreesToRadians(0),
      end: MathHelper.degreesToRadians(360),
    ).animate(curvedRotationController);

    sizeController.repeat();
    rotationController.repeat();

    bool changed = false;
    flagController.addListener(() { 
      if(flagController.value > 0.5 && ! changed)
        changed = true;
        setState(() {});
      if(flagController.value > 0.95 && changed) {
        changed = false;
        setState(() {});
      }
    });

    flagSizeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1.5), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: 1.5, end: 0.75), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 0.75, end: 1), weight: 25),
    ]).animate(flagController);
    flagController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: sizeAnimation,
          builder: (_, child) => Transform.scale(
            scale: sizeAnimation.value,
            child: child,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // _buildRing(),
              if(flagController.value >= 0.5) _buildFlag() else Container(),
              _buildMine(),
              
              if(flagController.value < 0.5) _buildFlag() else Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMine() {
    return AnimatedBuilder(
      animation: rotationAnimation,
      child: Icon(
        MinesweeperIcons.mine,
        color: Colors.black,
        size: _mineSize,
      ),
      builder: (_, child) {
        return Transform.rotate(
          angle: rotationAnimation.value,
          child: child,
        );
      },
    );
  }

  Widget _buildRing() {
    return Transform(
      transform: new Matrix4.rotationX(0.65 * pi)
        ..multiply(new Matrix4.translationValues(0, -(_mineSize * 3.0), 0)),
      child: Container(
        width: _mineSize * 1.7,
        height: _mineSize * 1.7,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 3),
            borderRadius: BorderRadius.circular(200)),
      ),
    );
  }


  double flagSize = 40;

  Widget _buildFlag() {
    return AnimatedBuilder(
        animation: flagController,
        builder: (_, child) => Transform.scale(
          scale: flagSizeAnimation.value,
          child: Transform.translate(
                offset: calculate(flagController.value),
                child: child,
              ),
        ),
        child: Icon(
          MinesweeperIcons.flag,
          color: Colors.amber,
          size: flagSize,
        ));
  }

  Offset calculate(value) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
  }

  Path path = Path()
    ..addOval(Rect.fromLTWH(
        -1 * ((_mineSize * 1.6) / 2),
        -1 * ((_mineSize * 1.7) / 6),
        ((_mineSize * 1.7)),
        (_mineSize * 1.6) / 2));

  static get matrix {
    var matrix = new Matrix4.rotationX(0.65 * pi)
      ..multiply(new Matrix4.translationValues(0, -(_mineSize * 3.0), 0));
    return matrix.storage;
  }
}

class CirclePath extends CustomPainter {
  final double radius;

  CirclePath(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path = Path();
    path.addOval(Rect.fromCircle(center: Offset(0, 0), radius: radius));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
