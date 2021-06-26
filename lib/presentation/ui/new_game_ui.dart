import 'package:flutter/material.dart';
import 'package:minesweeper_flutter/helpers/context_extensions.dart';

class NewGameUI extends StatelessWidget {
  const NewGameUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.localization().newGame),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LevelSettingsCard(),
            ],
          ),
        ));
  }
}

class LevelSettingsCard extends StatelessWidget {
  const LevelSettingsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(),
        color: Colors.white,
        boxShadow: [
          BoxShadow(offset: Offset(1, 1)),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.ac_unit),
        onPressed: () => print("ez"),
      ),
    );
  }
}
