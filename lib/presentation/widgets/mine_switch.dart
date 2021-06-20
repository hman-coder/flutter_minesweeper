import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/helpers/math.dart';
import 'package:minesweeper_flutter/presentation/widgets/flag_icon_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/mine_icon_widget.dart';

/// A switch that shows a flag when it is active, and a mine otherwise.
/// This widget is mainly used in a [ListTile].
class MineSwitch extends StatefulWidget {
  final double size;

  final bool value;

  final Color activeColor;

  final Color inactiveColor;

  const MineSwitch({
    this.size = 45,
    required this.value,
    Key? key,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.black,
  }) : super(key: key);

  @override
  _MineSwitchState createState() => _MineSwitchState();
}

class _MineSwitchState extends State<MineSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  bool get _stateIsActive => controller.value > 0.5;

  late Animation<Color?> colorAnim;

  late Animation<double> rotationAnim;

  late Widget _currentChild;

  @override
  initState() {
    _initController();
    _initAnimations();
    _initCurrentChild();
    super.initState();
  }

  void _initController() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    controller.value = widget.value ? 1 : 0;
    controller.addListener(() => setState(() => _updateChild()));
  }

  void _initAnimations() {
    rotationAnim = Tween<double>(
            begin: MathHelper.degreesToRadians(0),
            end: MathHelper.degreesToRadians(360))
        .animate(controller);
    colorAnim = ColorTween(begin: widget.inactiveColor, end: widget.activeColor)
        .animate(controller);
  }

  void _initCurrentChild() {
    _currentChild = widget.value ? activeWidget : inactiveWidget;
  }

  void _updateChild() {
    if (_stateIsActive)
      _currentChild = activeWidget;
    else
      _currentChild = inactiveWidget;
  }

  void _runController() {
    if (controller.status == AnimationStatus.completed ||
        controller.status == AnimationStatus.forward)
      controller.reverse();
    else
      controller.forward();
  }

  Widget get activeWidget =>
      FlagIcon(size: widget.size - 15, color: widget.activeColor);

  Widget get inactiveWidget =>
      MineIcon(size: widget.size - 15, color: widget.inactiveColor);

  /// Run the controller when the value of [widget.value] is changed.
  @override
  void didUpdateWidget(covariant MineSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _runController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: colorAnim.value!.withOpacity(0.3),
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(rotationAnim.value),
        child: _currentChild,
      ),
    );
  }
}
