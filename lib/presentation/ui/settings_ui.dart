import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/game_settings.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({Key? key}) : super(key: key);

  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SwitchListTile(
            title: Text("music"),
            activeColor: Colors.amber,
            value: context.watch<GameSettingsBloc>().state.music,
            onChanged: (value) => context.read<GameSettingsBloc>().toggleMusic(),
            subtitle: Text("music is beautiful"),
          ),
          SwitchListTile(
            title: Text("sfx"),
            activeColor: Colors.amber,
            value: context.watch<GameSettingsBloc>().state.sfx,
            onChanged: (value) => context.read<GameSettingsBloc>().toggleSFX(),            
          ),
          SwitchListTile(
            title: Text("notifications"),
            activeColor: Colors.amber,
            value: context.watch<GameSettingsBloc>().state.notifications,
            onChanged: (value) => context.read<GameSettingsBloc>().toggleNotifications(),
          )
        ],
      ),
    );
  }
}
