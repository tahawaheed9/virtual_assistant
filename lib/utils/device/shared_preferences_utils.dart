import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static const String _darkThemePrefKey = 'dark_theme';

  Future<void> setThemePreference(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_darkThemePrefKey, value);
  }

  Future<bool> getThemePreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_darkThemePrefKey) ?? false;
  }
}
