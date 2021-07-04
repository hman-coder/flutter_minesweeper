import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/bloc/audio_manager.dart';
import 'package:minesweeper_flutter/bloc/game_settings.dart';
import 'package:minesweeper_flutter/presentation/widgets/mine_switch.dart';
import 'package:minesweeper_flutter/helpers/context_extensions.dart';

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
            title: Text(context.localization().music),
            onTap: () {
              AudioManager().toggle();
              context.read<GameSettingsBloc>().add(ToggleMusicEvent());
            },
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: BlocBuilder<GameSettingsBloc, GameSettingsState>(
                buildWhen: (prev, cur) =>
                    cur is MusicOffState ||
                    cur is MusicOnState ||
                    cur is ReloadedState,
                builder: (context, state) {
                  var value;
                  if (state is MusicOffState)
                    value = false;
                  else if (state is MusicOnState)
                    value = true;
                  else
                    value = context.read<GameSettingsBloc>().settings.music;
                  return MineSwitch(
                    size: 40,
                    value: value,
                  );
                },
              ),
            ),
          ),
          ListTile(
            title: Text(context.localization().sfx),
            onTap: () {
              AudioManager().toggle();
              context.read<GameSettingsBloc>().add(ToggleSFXEvent());
            },
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: BlocBuilder<GameSettingsBloc, GameSettingsState>(
                buildWhen: (prev, cur) =>
                    cur is SFXOffState ||
                    cur is SFXOnState ||
                    cur is ReloadedState,
                builder: (context, state) {
                  var value;
                  if (state is SFXOffState)
                    value = false;
                  else if (state is SFXOnState)
                    value = true;
                  else
                    value = context.read<GameSettingsBloc>().settings.sfx;
                  return MineSwitch(
                    size: 40,
                    value: value,
                  );
                },
              ),
            ),
          ),
          ListTile(
            title: Text(context.localization().notifications),
            onTap: () {
              AudioManager().toggle();
              context.read<GameSettingsBloc>().add(ToggleNotificationsEvent());
            },
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: BlocBuilder<GameSettingsBloc, GameSettingsState>(
                buildWhen: (prev, cur) =>
                    cur is NotificationsOffState ||
                    cur is NotificationsOnState ||
                    cur is ReloadedState,
                builder: (context, state) {
                  var value;
                  if (state is NotificationsOffState)
                    value = false;
                  else if (state is NotificationsOnState)
                    value = true;
                  else
                    value = context.read<GameSettingsBloc>().settings.notifications;
                  return MineSwitch(
                    size: 40,
                    value: value,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
