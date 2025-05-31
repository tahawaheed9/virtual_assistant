import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/views/components/custom_heading.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_bloc.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_event.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_state.dart';

class AppearanceSettings extends StatelessWidget {
  const AppearanceSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Settings Heading...
        CustomHeading(headingTitle: 'Appearance'),

        // Dart Theme...
        ListTile(
          title: const Text('Dark theme'),
          subtitle: const Text('Will never turn off automatically'),
          trailing: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Switch.adaptive(
                value: state.isDarkTheme,
                onChanged: <bool>(value) {
                  context.read<ThemeBloc>().add(
                    ToggleButtonThemeEvent(isDarkTheme: !state.isDarkTheme),
                  );
                },
              );
            },
          ),
        ),

        // Category End...
        Divider(),
      ],
    );
  }
}
