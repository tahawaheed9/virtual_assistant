import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/app.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_bloc.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_event.dart';

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

  runApp(
    BlocProvider<ThemeBloc>(
      create: (_) => ThemeBloc()..add(const LoadThemeEvent()),
      child: const MyApp(),
    ),
  );
}
