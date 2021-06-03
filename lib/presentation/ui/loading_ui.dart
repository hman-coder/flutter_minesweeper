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
              LoadingWidget(type: LoadingWidgetType.screen_width_scan),
              SizedBox(height: 100,),
              Text("Loading..."),
            ],
          ),
        ),
      ),
    );
  }
}
