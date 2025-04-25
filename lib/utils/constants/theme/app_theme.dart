import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const String kDefaultFontFamily = 'Cera Pro';

  static const Color mainFontColor = Color.fromRGBO(19, 61, 95, 1);
  static const Color firstSuggestionBoxColor = Color.fromRGBO(165, 231, 244, 1);
  static const Color secondSuggestionBoxColor = Color.fromRGBO(
    157,
    202,
    235,
    1,
  );
  static const Color thirdSuggestionBoxColor = Color.fromRGBO(162, 238, 239, 1);
  static const Color assistantCircleColor = Color.fromRGBO(209, 243, 249, 1);
  static const Color borderColor = Color.fromRGBO(200, 200, 200, 1);
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;

  static ThemeData lightThemeData({required bool useMaterial3}) =>
      ThemeData.light(useMaterial3: useMaterial3).copyWith(
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: const AppBarTheme(backgroundColor: whiteColor),
      );
}
