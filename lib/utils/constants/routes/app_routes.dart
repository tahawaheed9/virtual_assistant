import 'package:flutter/material.dart';

import 'package:virtual_assistant/views/settings/settings_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String settingsRoute = '/settings';

  static Map<String, Widget Function(BuildContext context)> routes = {
    settingsRoute: (context) => const SettingsView(),
  };
}