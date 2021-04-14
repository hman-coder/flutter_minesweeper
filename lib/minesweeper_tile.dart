import 'package:flutter/material.dart';

class MinesweeperTile extends StatefulWidget {
  final double width;

  final double height;

  final Widget unexploredWidget;

  final Widget exploredWidget;

  final Widget flaggedWidget;

  const MinesweeperTile({
    Key key,
    @required this.width,
    @required this.height,
    @required this.unexploredWidget,
    @required this.exploredWidget,
    @required this.flaggedWidget,
  }) : super(key: key);

  @override
  _MinesweeperTileState createState() => _MinesweeperTileState();
}

class _MinesweeperTileState extends State<MinesweeperTile> {
  Widget activeWidget;

  @override
  void initState() {
    this.activeWidget = widget.unexploredWidget;
    super.initState();
  }

  void switchWidget() {
    activeWidget = activeWidget == widget.unexploredWidget
        ? activeWidget = widget.exploredWidget
        : activeWidget = widget.unexploredWidget;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => switchWidget()),
      child: Container(
        width: widget.height,
        height: widget.width,
        child: Center(child: activeWidget),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
