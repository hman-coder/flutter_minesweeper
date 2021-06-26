import 'package:flutter/material.dart';

/// A normal [Text] widget. However, its [TextStyle] is based on
/// the [type] variable. It reduces boilerplate code. 
class TextWidget extends StatelessWidget {
  final TextWidgetType type;

  final String data;

  final InlineSpan? textSpan;

  final StrutStyle? strutStyle;

  final TextAlign? textAlign;

  final TextDirection? textDirection;

  final Locale? locale;

  final bool? softWrap;

  final TextOverflow? overflow;

  final double? textScaleFactor;

  final int? maxLines;

  final String? semanticsLabel;

  final TextWidthBasis? textWidthBasis;

  final TextHeightBehavior? textHeightBehavior;

  const TextWidget(
      {Key? key,
      required this.type,
      required this.data,
      this.textSpan,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.textHeightBehavior})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.data,
      style: _style(context),
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }

  TextStyle? _style(BuildContext context) {
    switch (this.type) {
      case TextWidgetType.headline6:
        return Theme.of(context).textTheme.headline6;
      case TextWidgetType.bodyText2:
        return Theme.of(context).textTheme.bodyText2;
      case TextWidgetType.subtitle1:
        return Theme.of(context).textTheme.subtitle1;
      case TextWidgetType.subtitle2:
        return Theme.of(context).textTheme.subtitle2;
    }
  }
}

enum TextWidgetType { headline6, bodyText2, subtitle1, subtitle2 }
