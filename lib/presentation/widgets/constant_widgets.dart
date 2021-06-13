import 'package:flutter/material.dart';

final Widget Function(Animation animation, Widget child) defaultDelayedTransition =
    (animation, child) => Transform.translate(
          offset: Offset(0, (100 - (animation.value * 100)).toDouble()),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
