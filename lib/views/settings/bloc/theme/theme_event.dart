import 'package:flutter/foundation.dart';

@immutable
sealed class ThemeEvent {
  const ThemeEvent();
}

class LoadThemeEvent extends ThemeEvent {
  const LoadThemeEvent();
}

class ToggleButtonThemeEvent extends ThemeEvent {
  final bool isDarkTheme;

  const ToggleButtonThemeEvent({required this.isDarkTheme});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToggleButtonThemeEvent &&
          runtimeType == other.runtimeType &&
          isDarkTheme == other.isDarkTheme;

  @override
  int get hashCode => isDarkTheme.hashCode;
}
