import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
import 'package:minesweeper_flutter/presentation/widgets/loading_widget.dart';
import 'package:minesweeper_flutter/presentation/widgets/mine_icon_widget.dart';
import 'package:minesweeper_flutter/helpers/context_extensions.dart';

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
                onPressed: () {
                  Navigator.pushReplacementNamed(context, kprMainMenuRoute);
                },
                child: Text(context.localization().finish),
              ),
              Text(
                context.localization().minesweeper,
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
              Text("${context.localization().loading}..."),
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
          child: MineIcon(
            size: (animation.value * 300) + 150,
          )
        ),
      );
}
