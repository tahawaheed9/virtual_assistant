import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:virtual_assistant/controller/navigation_controller.dart';

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
              child: ZoomIn(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'M E N U',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),

          // Settings Tile...
          SlideInLeft(
            child: ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () => NavigationController.pushSettingsView(context),
            ),
          ),
        ],
      ),
    );
  }
}
