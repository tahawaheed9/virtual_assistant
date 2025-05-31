import 'package:flutter/material.dart';

@immutable
class ThemeState {
  final ThemeData themeData;
  final bool isDarkTheme;

  const ThemeState({required this.themeData, required this.isDarkTheme});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeState &&
          runtimeType == other.runtimeType &&
          themeData == other.themeData &&
          isDarkTheme == other.isDarkTheme;

  @override
  int get hashCode => themeData.hashCode ^ isDarkTheme.hashCode;
}
