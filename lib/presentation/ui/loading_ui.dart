import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/widgets/loading_widget.dart';

class LoadingUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Minesweeper", style: Theme.of(context).textTheme.headline5,),
              SizedBox(height: 150,),
              LoadingWidget(type: LoadingWidgetType.flag_circles_mine),
              SizedBox(height: 100,),
              Text("Loading..."),
            ],
          ),
        ),
      ),
    );
  }
}
