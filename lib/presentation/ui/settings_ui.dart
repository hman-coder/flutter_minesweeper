import 'package:flutter/material.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({Key? key}) : super(key: key);

  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  bool value = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SwitchListTile(
            title: Text("black"),
            activeColor: Colors.amber,
            value: value,
            onChanged: (value) => setState(() => this.value = value),
          )
        ],
      ),
    );
  }
}
