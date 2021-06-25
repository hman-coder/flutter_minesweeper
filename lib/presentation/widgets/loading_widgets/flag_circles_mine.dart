import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/helpers/math.dart';
import 'package:minesweeper_flutter/presentation/widgets/flag_icon_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/mine_icon_widget.dart';

/// A Loading animation widget that shows a flag rotating around a mine, like a moon circling a planet
class FlagCirclesMine extends StatefulWidget {
  @override
  _LoadingUIState createState() => _LoadingUIState();
}

class _LoadingUIState extends State<FlagCirclesMine> with TickerProviderStateMixin {
  late AnimationController sizeController;

  late Animation sizeAnimation;

  late AnimationController rotationController;

  late Animation<double> rotationAnimation;

  late AnimationController flagController;

  late Animation<double> flagSizeAnimation;

  static const double _mineSize = 150;

  @override
  void dispose() {
    sizeController.dispose();
    rotationController.dispose();
    flagController.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    _initSizeAnimations();
    _initMineRotationAnimations();
    _initFlagAnimations();
    super.initState();
  }

  /// Initializes components responsible for changing the size of the whole widget
  void _initSizeAnimations() {
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

  /// Initializes components responsible for rotating the mine
  void _initMineRotationAnimations() {
    this.rotationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    
    Animation<double> curvedRotationController =
        CurvedAnimation(parent: rotationController, curve: Curves.slowMiddle);

    rotationAnimation = Tween(
      begin: MathHelper.degreesToRadians(0),
      end: MathHelper.degreesToRadians(360),
    ).animate(curvedRotationController);

    rotationController.repeat();
  }

  // A flag used for determining whether the flag is in front of the mine or the other way around
  bool flagIsInFront = false;

  void _initFlagAnimations() {
    this.flagController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    
    flagController.addListener(() { 
      if(flagController.value > 0.5 && ! flagIsInFront)
        flagIsInFront = false;
        setState(() {});
      if(flagController.value > 0.95 && flagIsInFront) {
        flagIsInFront = true;
        setState(() {});
      }
    });

    // The animation starts when the flag is on the right-side of the mine
    flagSizeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1.5), weight: 25), 
      TweenSequenceItem(tween: Tween<double>(begin: 1.5, end: 0.75), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 0.75, end: 1), weight: 25),
    ]).animate(flagController);
    flagController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
          animation: sizeAnimation,
          builder: (_, child) => Transform.scale(
            scale: sizeAnimation.value,
            child: child,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if(flagIsInFront) _buildMine() else _buildFlag(),
              
              if(flagIsInFront) _buildFlag() else _buildMine(),
              
            ],
          ),
        ),
      );
  }

  Widget _buildMine() {
    return AnimatedBuilder(
      animation: rotationAnimation,
      child: MineIcon(size: _mineSize,),
      builder: (_, child) {
        return Transform.rotate(
          angle: rotationAnimation.value,
          child: child,
        );
      },
    );
  }
  double flagSize = 40;

  Widget _buildFlag() {
    return AnimatedBuilder(
        animation: flagController,
        builder: (_, child) => Transform.scale(
          scale: flagSizeAnimation.value,
          child: Transform.translate(
                offset: _calculate(flagController.value),
                child: child,
              ),
        ),
        child: FlagIcon(
          size: flagSize,
        ));
  }

  /// Calculates the correct position of the flag as determined by the path
  Offset _calculate(value) {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
  }

  // This is the path that the flag will take as it travels
  Path _path = Path()
    ..addOval(Rect.fromLTWH(
        -1 * ((_mineSize * 1.6) / 2),
        -1 * ((_mineSize * 1.7) / 6),
        ((_mineSize * 1.7)),
        (_mineSize * 1.6) / 2));

}