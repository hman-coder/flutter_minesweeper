import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/bloc/audio_manager.dart';

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

  @override
  void initState() {
    int initialItemIndex = widget.values.indexOf(widget.value);
    scrollController =
        FixedExtentScrollController(initialItem: initialItemIndex);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _animateTo(int index) {
    scrollController.animateToItem(index,
        duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLeftArrow(context),
        Expanded(child: _buildList()),
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

  Widget _buildList() {
    return RotatedBox(
      quarterTurns: 3,
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: (index) {
          AudioManager().selectedItemChanged();
          widget.onValueChanged(widget.values[(index)]);
        },
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
        controller: scrollController,
        physics: FixedExtentScrollPhysics(),
      ),
    );
  }
}
