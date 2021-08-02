import 'package:flutter/foundation.dart';

/// A mixin whose main purpose is to add a functionality that allows its implementer -
/// typically a widget - to have two different ways of changing a state of type [T] :
/// internal (from inside the widget) and external (from outside the widget).
/// An external change comes from outside the widget. This typically happens when
/// the parent widget rebuilds and changes one of the passed parameters to the
/// child widget.
/// An internal change comes from inside the widget, such as changing the selected
/// item from a list ([DropdownButton], [ListWheelScrollView], etc).
mixin ValueChangeRegulator<T> {
  externalChange(T newValue);

  internalChange(T newValue);
}

abstract class ValueRegulator<T> extends ValueNotifier<T>
    with ValueChangeRegulator<T> {
  ValueRegulator(T value) : super(value);

  void externalChange(T newValue, [Function()? callback]);

  void internalChange(T newValue);
}
