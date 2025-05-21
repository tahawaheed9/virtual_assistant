import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/routes/app_routes.dart';

class NavigationController {
  NavigationController._();

  static pushSettingsView(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.settingsRoute);
  }
}
