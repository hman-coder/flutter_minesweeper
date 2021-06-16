import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
import 'package:minesweeper_flutter/presentation/icons/minesweeper_icons.dart';
import 'package:minesweeper_flutter/presentation/widgets/loading_widget.dart';

class LoadingUI extends StatefulWidget {
  @override
  _LoadingUIState createState() => _LoadingUIState();
}

class _LoadingUIState extends State<LoadingUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, kprMainMenuRoute),
                child: Text("Finish"),
              ),
              Text(
                "Minesweeper",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 150,
              ),
              Hero(
                tag: "mine",
                child: LoadingWidget(type: LoadingWidgetType.flag_circles_mine),
                flightShuttleBuilder: _shuttleBuilder,
              ),
              SizedBox(
                height: 100,
              ),
              Text("Loading..."),
            ],
          ),
        ),
      ),
    );
  }

  HeroFlightShuttleBuilder get _shuttleBuilder => (flightContext, animation,
          flightDirection, fromHeroContext, toHeroContext) =>
      AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Opacity(
          opacity: 1 - (animation.value * 0.5),
          child: Icon(
            MinesweeperIcons.mine,
            color: Colors.black,
            size: (animation.value * 300) + 150,
          ),
        ),
      );
}
