import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/views/text_model/text_model_view.dart';
import 'package:virtual_assistant/utils/constants/routes/app_routes.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_bloc.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_event.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_state.dart';
import 'package:virtual_assistant/views/text_model/bloc/text_model_bloc.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc()..add(const LoadThemeEvent()),
        ),
        BlocProvider<TextModelBloc>(create: (_) => TextModelBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: AppTextStrings.appTitle,
            theme: state.themeData,
            debugShowCheckedModeBanner: false,
            routes: AppRoutes.routes,
            home: const TextModelView(),
          );
        },
      ),
    );
  }
}
