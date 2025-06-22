import 'package:flutter/foundation.dart';

@immutable
sealed class TextModelState {
  const TextModelState();

  bool get isChatEnabled => true;
}

class InitialTextModelState extends TextModelState {
  const InitialTextModelState();
}

class GeneratingResponseTextModelState extends TextModelState {
  const GeneratingResponseTextModelState();
}

class ListeningTextModelState extends TextModelState {
  const ListeningTextModelState();

  @override
  bool get isChatEnabled => false;
}

class LoadedTextModelState extends TextModelState {
  final String response;

  const LoadedTextModelState({required this.response});
}

class ErrorTextModelState extends TextModelState {
  final String error;

  const ErrorTextModelState({required this.error});
}
