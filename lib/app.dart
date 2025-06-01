import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/views/home/home_view.dart';
import 'package:virtual_assistant/views/home/bloc/home_bloc.dart';
import 'package:virtual_assistant/utils/constants/routes/app_routes.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_bloc.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc()..add(const LoadThemeEvent()),
        ),
        BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
      ],
      child: MaterialApp(
        title: AppTextStrings.appTitle,
        theme: context.watch<ThemeBloc>().state.themeData,
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        home: const HomeView(),
      ),
    );
  }
}
