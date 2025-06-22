import 'package:flutter/foundation.dart';

@immutable
sealed class TextModelEvent {
  const TextModelEvent();
}

class InitialTextModelEvent extends TextModelEvent {
  const InitialTextModelEvent();
}

class SpeechButtonPressedTextModelEvent extends TextModelEvent {
  const SpeechButtonPressedTextModelEvent();
}

class SendButtonPressedTextModelEvent extends TextModelEvent {
  final String prompt;

  const SendButtonPressedTextModelEvent({required this.prompt});
}
