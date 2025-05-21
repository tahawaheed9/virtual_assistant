import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:virtual_assistant/views/home/home_view.dart';
import 'package:virtual_assistant/utils/constants/theme/app_theme.dart';
import 'package:virtual_assistant/utils/constants/routes/app_routes.dart';
import 'package:virtual_assistant/utils/constants/theme/text_strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Setting the background for the status bar to transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Status Bar Customization...
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,

      // System Navigation Bar Customization...
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting the theme of the system...
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    final AppTheme appTheme = AppTheme();

    return MaterialApp(
      title: AppTextStrings.appTitle,
      theme:
          brightness == Brightness.light
              ? appTheme.lightTheme()
              : appTheme.darkTheme(),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      home: const HomeView(),
    );
  }
}
