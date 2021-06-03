import 'package:flutter/material.dart';

/// Clips a percentage of the widget's width, starting from either the right
///  or the left side of the widget, depending on the given [TextDirection]
class HorizontalPercentageClipper extends CustomClipper<Rect> {
  /// How much of the widget's size should be clipped.
  final double percentageWidthToHide;

  /// Whether this widgets clips starting from left or right
  final TextDirection direction;

  HorizontalPercentageClipper(this.percentageWidthToHide, this.direction);

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
  bool shouldReclip(covariant HorizontalPercentageClipper oldClipper) {
    return true;
  }
}
