import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/bloc/audio_manager.dart';
import 'package:minesweeper_flutter/presentation/widget_add_ons/value_regulator.dart';

/// A list of items, with right and left arrows, through which one can pick an item.
class Spinner<T> extends StatefulWidget {
  /// Vertical or horizontal spinner. Currently only horizontal is supported.
  final Axis axis;

  /// What happens when the selected value is changed
  final ValueChanged<T> onValueChanged;

  /// The current selected value
  final T value;

  /// All values available to select from
  final List<T> values;

  /// Builds each item's represntation in the list.
  final Widget Function(T) itemBuilder;

  final double itemWidth;

  const Spinner({
    Key? key,
    required this.values,
    required this.itemBuilder,
    required this.onValueChanged,
    required this.value,
    this.itemWidth = 60,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  @override
  _SpinnerState<T> createState() => _SpinnerState<T>();
}

class _SpinnerState<T> extends State<Spinner<T>> {
  late FixedExtentScrollController scrollController;

  /// Used to regulate changes from both outside and within
  /// the widget. This prevents a loop where an external change
  /// would trigger an internal change, and the latter internal 
  /// would trigger a new external change, and so on.
  late ValueRegulator<T> valueRegulator;

  @override
  void initState() {
    super.initState();
    int initialItemIndex = widget.values.indexOf(widget.value);
    scrollController =
        FixedExtentScrollController(initialItem: initialItemIndex);
    this.valueRegulator = SpinnerValueRegulator<T>(widget.value);
    valueRegulator
        .addListener(() => widget.onValueChanged(valueRegulator.value));
  }

  @override
  void dispose() {
    scrollController.dispose();
    valueRegulator.dispose();
    super.dispose();
  }

  /// Animates the [scrollController] to the given index
  _animateTo(int index) {
    scrollController.animateToItem(
      index,
      duration: Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(covariant Spinner<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool valueChanged = valueRegulator.value != widget.value;
    if (valueChanged) _handleExternalValueChange(oldWidget.value);

    bool valuesChanged = widget.values != oldWidget.values;
    if (valuesChanged) _handleValueSetChange(oldWidget.value);
  }

  void _handleExternalValueChange(T oldValue) {
    valueRegulator.externalChange(widget.value, () {
      T currentValue = this.valueRegulator.value;
      int newValueIndex = widget.values.indexOf(currentValue);
      int oldValueIndex = widget.values.indexOf(oldValue);
      int difference = newValueIndex - oldValueIndex;
      int currentIndex = scrollController.selectedItem;
      _animateTo(currentIndex + difference);
    });
  }

  void _handleValueSetChange(T oldValue) {
    if (widget.values.contains(oldValue)) {
      _handleExternalValueChange(oldValue);
    } else if (widget.values.isNotEmpty) {
      valueRegulator.externalChange(widget.values[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLeftArrow(context),
        Expanded(
          child: _SpinnerList<T>(
            axis: widget.axis,
            itemBuilder: widget.itemBuilder,
            itemWidth: widget.itemWidth,
            onValueChanged: (value) => valueRegulator.internalChange(value),
            scrollController: scrollController,
            value: this.valueRegulator.value,
            values: widget.values,
          ),
        ),
        _buildRightArrow(context),
      ],
    );
  }

  Widget _buildLeftArrow(BuildContext context) {
    return IconButton(
      onPressed: () {
        _animateTo(scrollController.selectedItem - 1);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  Widget _buildRightArrow(BuildContext context) {
    return IconButton(
      onPressed: () {
        _animateTo(scrollController.selectedItem + 1);
      },
      icon: Icon(Icons.arrow_forward),
    );
  }
}

class _SpinnerList<T> extends StatefulWidget {
  /// Vertical or horizontal spinner. Currently only horizontal is supported.
  final Axis axis;

  /// What happens when the selected value is changed
  final ValueChanged<T> onValueChanged;

  /// The current selected value
  final T value;

  /// All values available to select from
  final List<T> values;

  /// Builds each item's represntation in the list.
  final Widget Function(T) itemBuilder;

  final double itemWidth;

  final FixedExtentScrollController scrollController;

  const _SpinnerList(
      {Key? key,
      required this.axis,
      required this.onValueChanged,
      required this.value,
      required this.values,
      required this.itemBuilder,
      required this.itemWidth,
      required this.scrollController})
      : super(key: key);

  @override
  __SpinnerListState<T> createState() => __SpinnerListState<T>();
}

class __SpinnerListState<T> extends State<_SpinnerList<T>> {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: (index) =>
            widget.onValueChanged(widget.values[index]),
        diameterRatio: 1.5,
        overAndUnderCenterOpacity: 0.5,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: widget.values
              .map<Widget>(
                (e) => RotatedBox(
                  quarterTurns: 1,
                  child: Center(
                    child: widget.itemBuilder(e),
                  ),
                ),
              )
              .toList(),
        ),
        itemExtent: widget.itemWidth,
        controller: widget.scrollController,
        physics: FixedExtentScrollPhysics(),
      ),
    );
  }
}

class SpinnerValueRegulator<T> extends ValueRegulator<T> {
  SpinnerValueRegulator(value) : super(value);

  /// Keeps track of the last change source
  bool wasInternallyChanged = false;

  @override
  void externalChange(T newValue, [Function()? callback]) {
    if (wasInternallyChanged) {
      wasInternallyChanged = false;
    } else {
      this.value = newValue;
      if (callback != null) callback();
      notifyListeners();
    }
  }

  @override
  void internalChange(T newValue) {
    AudioManager().selectedItemChanged();
    this.value = newValue;
    wasInternallyChanged = true;
    notifyListeners();
  }
}