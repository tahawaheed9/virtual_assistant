import 'package:flutter/material.dart';

import 'package:virtual_assistant/controller/navigation_controller.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          // Menu Header...
          DrawerHeader(
            child: Center(
              child: Text(
                AppTextStrings.appDrawerHeading,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // Settings Tile...
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text(AppTextStrings.appDrawerSettingTileText),
            onTap: () => NavigationController.pushSettingsView(context),
          ),
        ],
      ),
    );
  }
}