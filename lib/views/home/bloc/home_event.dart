import 'package:flutter/material.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class InitialHomeEvent extends HomeEvent {
  final BuildContext context;

  const InitialHomeEvent({required this.context});
}

class SpeechButtonPressedHomeEvent extends HomeEvent {
  final BuildContext context;
  bool isChatEnabled;

  SpeechButtonPressedHomeEvent({
    required this.context,
    required this.isChatEnabled,
  });
}

class SendButtonPressedHomeEvent extends HomeEvent {
  final String prompt;

  const SendButtonPressedHomeEvent({required this.prompt});
}
