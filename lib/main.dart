import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:virtual_assistant/app.dart';

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
