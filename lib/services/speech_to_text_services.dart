import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechToTextServices {
  final SpeechToText _speechToText = SpeechToText();
  String _recognizedWords = '';

  // Init Speech To Text...
  Future<bool> initSpeechToText() async {
    final bool isSpeechEnabled = await _speechToText.initialize(
      onStatus: (status) => debugPrint('Status: $status'),
      onError: (error) => debugPrint('Error: $error'),
    );
    return isSpeechEnabled;
  }

  // Start Listening to the User...
  Future<void> startListening() async {
    _recognizedWords = '';
    await _speechToText.listen(
      localeId: 'en_US',
      onResult: _getRecognizedSpeech
    );
  }

  // Stop Listening...
  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  String _getRecognizedSpeech(SpeechRecognitionResult result) {
    _recognizedWords = result.recognizedWords;
    debugPrint(_recognizedWords);
    return _recognizedWords;
  }

  /// Getting the instance of [isListening]...
  bool get isListening => _speechToText.isListening;

  /// Getting the instance of [isNotListening]...
  bool get isNotListening => _speechToText.isNotListening;

  /// Getting the instance of [hasPermission]...
  Future<bool> get hasPermission async => await _speechToText.hasPermission;

  /// Getting the last recognized words...
  String get getRecognizedWords => _recognizedWords;
}
