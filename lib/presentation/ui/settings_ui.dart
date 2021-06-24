import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/audio_manager.dart';
import 'package:minesweeper_flutter/bloc/game_settings_bloc.dart';
import 'package:minesweeper_flutter/presentation/widgets/mine_switch.dart';

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
          ListTile(
            title: Text("music"),
            subtitle: Text("music is beautiful"),
            onTap: () {
              AudioManager().toggle();
              context.read<GameSettingsBloc>().toggleMusic();
            },
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: MineSwitch(
                size: 40,
                value: context.watch<GameSettingsBloc>().state.music,
              ),
            ),
          ),
          ListTile(
              title: Text("sfx"),
              onTap: () {
                AudioManager().toggle();
                context.read<GameSettingsBloc>().toggleSFX();
              },
              trailing: Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: MineSwitch(
                  value: context.watch<GameSettingsBloc>().state.sfx,
                  size: 40,
                ),
              )),
          ListTile(
            title: Text("notifications"),
            onTap: () {
              AudioManager().toggle();
              context.read<GameSettingsBloc>().toggleNotifications();
            },
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: MineSwitch(
                value: context.watch<GameSettingsBloc>().state.notifications,
                size: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
