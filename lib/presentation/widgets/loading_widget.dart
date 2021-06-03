import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/presentation/widgets/loading_widgets/back_and_forth_scan.dart';
import 'package:minesweeper_flutter/presentation/widgets/loading_widgets/flag_circles_mine.dart';
import 'package:minesweeper_flutter/presentation/widgets/loading_widgets/screen_width_scan.dart';

/// Provides an easy access to all loading animations available.
class LoadingWidget extends StatelessWidget {

  final LoadingWidgetType type;

  const LoadingWidget({Key? key, required this.type}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    switch(type) {
      case LoadingWidgetType.flag_circles_mine:
        return FlagCirclesMine();

      case LoadingWidgetType.back_and_forth_scan:
        return BackAndForthScan();
        
      case LoadingWidgetType.screen_width_scan:
        return ScreenWidthScan();
    };
  }
}

enum LoadingWidgetType {
  flag_circles_mine, back_and_forth_scan, screen_width_scan
}