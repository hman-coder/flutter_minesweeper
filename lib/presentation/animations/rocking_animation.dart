import 'package:flutter/material.dart';

class RockingAnimation extends StatefulWidget {
  final double startingRadians;

  final double endingRadians;

  final Duration? duration;

  final Widget child;

  final AnimationController? controller;

  final double startingAnimationValue;

  const RockingAnimation({
    Key? key,
    required this.startingRadians,
    required this.endingRadians,
    this.duration = const Duration(seconds: 8),
    this.controller,
    this.startingAnimationValue = 0,
    required this.child,
  })  : assert(controller != null || duration != null, "You must specify either a duration or an animation controller"),
        assert(startingAnimationValue >= 0 && startingAnimationValue < 1, "startingAnimationValue must be between 0 and 1"),
        super(key: key);

  @override
  _RockingAnimationState createState() => _RockingAnimationState();
}

class _RockingAnimationState extends State<RockingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController? controller;
  
  late Animation animation;

  @override
  void initState() {
    this.controller = widget.controller;
    if (controller == null) {
      controller = AnimationController(vsync: this, duration: widget.duration);
      controller!.addStatusListener((status) {
        print(status);
        if (status == AnimationStatus.completed) controller!.reverse();
        if (status == AnimationStatus.dismissed) controller!.forward();
      });
      controller!.forward(from: widget.startingAnimationValue);
    }

    controller!.addListener(() => setState((){}));

    animation = Tween<double>(
            begin: widget.startingRadians, end: widget.endingRadians)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  void dispose() {
    if(widget.controller == null)
      controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(animation.value),
      child: widget.child);
  }
}
