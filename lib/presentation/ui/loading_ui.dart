import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/constants/routes.dart';
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
                    Navigator.pushNamed(context, kprMainMenuRoute),
                child: Text("Finish"),
              ),
              Text(
                "Minesweeper",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 150,
              ),
              LoadingWidget(type: LoadingWidgetType.flag_circles_mine),
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
}
