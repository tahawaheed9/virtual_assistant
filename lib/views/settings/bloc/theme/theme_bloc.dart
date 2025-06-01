import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/utils/constants/theme/app_theme.dart';
import 'package:virtual_assistant/utils/device/shared_preferences_utils.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_event.dart';
import 'package:virtual_assistant/views/settings/bloc/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final AppTheme _appTheme = AppTheme();
  final SharedPreferencesUtils _sharedPreferencesUtils =
      SharedPreferencesUtils();

  ThemeBloc()
    : super(
        ThemeState(themeData: AppTheme().lightTheme(), isDarkTheme: false),
      ) {
    on<LoadThemeEvent>((event, emit) async {
      final bool isDarkTheme =
          await _sharedPreferencesUtils.getThemePreferences();
      emit(
        ThemeState(
          themeData:
              isDarkTheme ? _appTheme.darkTheme() : _appTheme.lightTheme(),
          isDarkTheme: isDarkTheme,
        ),
      );
    });

    on<ToggleButtonThemeEvent>((event, emit) async {
      await _sharedPreferencesUtils.setThemePreference(event.isDarkTheme);
      emit(
        ThemeState(
          themeData:
              event.isDarkTheme
                  ? _appTheme.darkTheme()
                  : _appTheme.lightTheme(),
          isDarkTheme: event.isDarkTheme,
        ),
      );
    });
  }
}
