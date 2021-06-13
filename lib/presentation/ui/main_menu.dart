import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/widgets/constant_widgets.dart';
import 'package:minesweeper_flutter/presentation/widgets/delayed_widget.dart';

class MainMenuUI extends StatelessWidget {
  const MainMenuUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minesweeper"),
        toolbarHeight: 70,
      ),
      body: DelayedWidgetsController(
        overallDelay: Duration(seconds: 1),
        weights: [4, 4],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DelayedWidget(
                rank: 1,
                duration: Duration(milliseconds: 800),
                curve: Curves.decelerate,
                builder: defaultDelayedTransition,
                child: OutlinedButton(
                  onPressed: () => print("null"),
                  child: Text("New Game"),
                ),
              ),
              DelayedWidget(
                rank: 2,
                duration: Duration(milliseconds: 800),
                curve: Curves.decelerate,
                builder: defaultDelayedTransition,
                child: TextButton.icon(
                  onPressed: () {},
                  label: Text("Settings"),
                  icon: Icon(Icons.settings),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
