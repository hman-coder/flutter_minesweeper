import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/game_settings.dart';
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
            onTap: () => context.read<GameSettingsBloc>().toggleMusic(),
            trailing: MineSwitch(
              size: 40,
              value: context.watch<GameSettingsBloc>().state.music,
            ),
          ),
          ListTile(
            title: Text("sfx"),
            onTap: () {
              context.read<GameSettingsBloc>().toggleSFX();
              print(context.read<GameSettingsBloc>().state.sfx);
            },
            trailing: MineSwitch(
             value: context.watch<GameSettingsBloc>().state.sfx,
             size: 40,
            )
          ),
          ListTile(
            onTap: () => context.read<GameSettingsBloc>().toggleNotifications(),
            title: Text("notifications"),
            trailing: MineSwitch(
              value: context.watch<GameSettingsBloc>().state.notifications,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
