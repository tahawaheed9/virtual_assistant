import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechToTextServices {
  final SpeechToText _speechToText = SpeechToText();

  // Init Speech To Text...
  Future<bool> initSpeechToText() async {
    final isSpeechEnabled = await _speechToText.initialize(
      onStatus: (status) => debugPrint('Status: $status'),
      onError: (error) => debugPrint('Error: $error'),
    );
    return isSpeechEnabled;
  }

  // Start Listening to the User...
  Future<void> startListening() async {
    await _speechToText.listen(
      localeId: 'en_US',
      onResult: getRecognizedSpeech,
    );
  }

  // Stop Listening...
  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  String getRecognizedSpeech(SpeechRecognitionResult result) {
    final recognizedSpeech = result.recognizedWords;
    return recognizedSpeech;
  }

  /// Getting the instance of [isListening]...
  bool get isListening => _speechToText.isListening;

  /// Getting the instance of [isNotListening]...
  bool get isNotListening => _speechToText.isNotListening;

  /// Getting the instance of [hasPermission]...
  Future<bool> get hasPermission async => await _speechToText.hasPermission;
}
