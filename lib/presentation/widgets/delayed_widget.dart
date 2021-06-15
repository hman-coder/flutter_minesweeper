import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The builder used to build the delayed widget.
/// Should return the transformation that occurs, which uses the [animation] parameter. This is typically a
/// [Transform] widget. The child paramter is the [child] passed in by the [DelayedWidgetController] constructor.
typedef DelayedWidgetBuilder = Widget Function(
    Animation animation, Widget child);


/// A widget that provides an instance of [_DelayController] to its descendants.
class DelayedWidgetsController extends StatefulWidget {
  final List<int> weights;

  final Duration overallDelay;

  final Widget child;

  const DelayedWidgetsController({
    required this.child,
    required this.weights,
    required this.overallDelay,
    Key? key,
  }) : super(key: key);

  @override
  _DelayedWidgetsControllerState createState() =>
      _DelayedWidgetsControllerState();
}

class _DelayedWidgetsControllerState extends State<DelayedWidgetsController>
    with TickerProviderStateMixin {
  late _DelayController _delayController;

  @override
  void initState() {
    _delayController = _DelayController(
      vsync: this,
      weights: widget.weights,
      overallDuration: widget.overallDelay,
    );
    super.initState();
  }

  @override
  void dispose() {
    _delayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<_DelayController>.value(
      value: _delayController,
      child: this.widget.child,
    );
  }
}

/// A widget that shows its child after a delay. This widget requires a [DelayedWidgetsController] as an ancestor to function properly.
class DelayedWidget extends StatelessWidget {
  /// builder should return the transformation that occurs, which uses the [animation] parameter.
  /// The child paramter is the [child] passed in by the constructor.
  final DelayedWidgetBuilder builder;

  final Curve? curve;

  final Widget child;

  /// How long it takes for the widget to finish its appearance on the screen.
  final Duration duration;

  /// The order of the appearance of this widget.
  final int rank;

  const DelayedWidget({
    this.curve,
    required this.duration,
    required this.rank,
    required this.builder,
    required this.child,
    Key? key,
  })  : assert(rank > 0,
            "Rank should be a value between 1 and the length of the `weights` parameter of the ancestor DelayedWidgetsController."),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<_DelayController>(
      child: this.child,
      builder: (_, value, consumerChild) {
        var animation = value.getAnimationForIndex(rank, duration, curve);
        if (rank > value.weights.length)
          throw Exception(
              "Rank should be a value between 1 and the length of the `weights` parameter of the ancestor DelayedWidgetsController.");

        return AnimatedBuilder(
          animation: value.getAnimationForIndex(rank, duration),
          builder: (context, animationChild) =>
              builder(animation, animationChild!),
          child: consumerChild,
        );
      },
    );
  }
}

class _DelayController {
  /// Used to provide relevant animations to descendants. This parameter is provided by a [DelayedWidgetsController].
  final TickerProvider vsync;

  /// A set of values that define the delays of the descendant [DelayedWidget]s. These weights represnt a fraction of 
  /// [overallDuration] . For example, if [weights] == [0, 65, 35], and [overallDuration] == 1.seconds, then all descendant
  /// [DelayedWidget]s with a rank of 1 will start to appear with 0 seconds delay, a rank of 2 with 650 milliseconds delay,
  /// and a rank of 3 with 1000 milliseconds delay.
  final List<int> weights;

  /// The time it takes for the last widget to appear
  final Duration overallDuration;

  /// The set of animations to be used by the descendant [DelayedWidget]s.
  final List<Animation?> animations;

  /// Dispose methods for all created [AnimationController]s and [Timer]s.
  final List<Function()> disposables = [];

  int total = 0;

  _DelayController({
    required this.vsync,
    required this.weights,
    required this.overallDuration,
  }) : animations = List.filled(weights.length, null) {
    weights.forEach((element) => total += element);
  }

  Animation getAnimationForIndex(int rank, Duration duration, [Curve? curve]) {
    int index = rank - 1;
    if (animations[index] == null) {
      int totalWeight = 0;
      for(int i = 0; i <= index; i++) totalWeight += weights[i];
      double fraction = totalWeight / total;
      int delayInMilliseconds =
          rank * (fraction * overallDuration.inMilliseconds).truncate();
      Duration delayDuration = Duration(milliseconds: delayInMilliseconds);
      AnimationController controller =
          AnimationController(vsync: vsync, duration: duration);

      Animation animation = curve == null
          ? controller
          : CurvedAnimation(parent: controller, curve: curve);

      Timer timer = Timer(delayDuration, () => controller.forward());
      disposables.add(() {
        controller.dispose();
        timer.cancel();
      });

      animations[index] = animation;
    }

    return animations[index]!;
  }

  void dispose() {
    for (Function f in disposables) f();
  }
}
