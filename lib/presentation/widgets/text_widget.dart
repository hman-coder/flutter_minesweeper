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

  final Color? color;

  const TextWidget({
    Key? key,
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
    this.textHeightBehavior,
    this.color,
  }) : super(key: key);

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
    TextStyle? ret;
    switch (this.type) {
      case TextWidgetType.headline6:
        ret= Theme.of(context).textTheme.headline6;
        break;
      case TextWidgetType.bodyText2:
        ret = Theme.of(context).textTheme.bodyText2;
        break;
      case TextWidgetType.subtitle1:
        ret = Theme.of(context).textTheme.subtitle1;
        break;
      case TextWidgetType.subtitle2:
        ret = Theme.of(context).textTheme.subtitle2;
        break;
    }
    if(color != null) ret = ret!.copyWith(color: color);
    return ret;
  }
}

enum TextWidgetType { headline6, bodyText2, subtitle1, subtitle2 }
