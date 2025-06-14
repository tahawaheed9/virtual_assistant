import 'package:flutter/foundation.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

class InitialHomeEvent extends HomeEvent {
  const InitialHomeEvent();
}

class SpeechButtonPressedHomeEvent extends HomeEvent {
  const SpeechButtonPressedHomeEvent();
}

class SendButtonPressedHomeEvent extends HomeEvent {
  final String prompt;

  const SendButtonPressedHomeEvent({required this.prompt});
}
