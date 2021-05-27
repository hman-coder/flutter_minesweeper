import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/minesweeper_tile.dart';

class MinesweeperWidget extends StatelessWidget {
  final List<int> mock = [1, 2, 3, 4, 5, 6, 7, 8,];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            print(constraints.maxWidth);
            print(constraints.maxHeight);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
            
              children: mock
                  .map<Widget>((e) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [1, 2, 3, 4, 5, 6, 7, 8,]
                            .map<Widget>((e) => MinesweeperTile(
                              width: 35,
                              height: 35,
                              unexploredWidget: Text('un'),
                              exploredWidget: Text(e.toString()),
                              flaggedWidget: Text('f'),
                            ))
                            .toList(),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

// Remove padding from the sides of the puzzle
// Determine the size of the whole puzzle
// Determine the size of each
