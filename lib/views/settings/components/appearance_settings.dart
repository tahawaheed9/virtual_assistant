import 'package:flutter/material.dart';

import 'package:virtual_assistant/views/components/custom_heading.dart';

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
          trailing: Switch.adaptive(value: true, onChanged: <bool>(value) {}),
        ),

        // Category End...
        Divider(),
      ],
    );
  }
}
