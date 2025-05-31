import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/services/ai_services.dart';
import 'package:virtual_assistant/views/home/home_view.dart';
import 'package:virtual_assistant/views/home/bloc/home_bloc.dart';
import 'package:virtual_assistant/services/speech_to_text_services.dart';
import 'package:virtual_assistant/utils/constants/routes/app_routes.dart';
import 'package:virtual_assistant/utils/constants/theme/text_strings.dart';
import 'package:virtual_assistant/utils/device/shared_preferences_utils.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_bloc.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_event.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create:
              (_) =>
                  ThemeBloc(SharedPreferencesUtils())
                    ..add(const LoadThemeEvent()),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(SpeechToTextServices(), AIServices()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: AppTextStrings.appTitle,
            theme: state.themeData,
            debugShowCheckedModeBanner: false,
            routes: AppRoutes.routes,
            home: const HomeView(),
          );
        },
      ),
    );
  }
}
