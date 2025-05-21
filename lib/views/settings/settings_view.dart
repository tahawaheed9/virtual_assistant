import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/components/custom_app_bar.dart';
import 'package:virtual_assistant/views/components/custom_heading.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        child: Center(
          child: Column(
            children: <Widget>[
              CustomHeading(headingTitle: 'Appearance'),
              ListTile(
                title: const Text('Dark theme'),
                subtitle: const Text('Will never turn off automatically'),
                trailing: Switch.adaptive(
                  value: true,
                  onChanged: <bool>(value) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
