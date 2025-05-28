import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_to_text.dart';

import 'package:virtual_assistant/utils/constants/app_enums.dart';
import 'package:virtual_assistant/utils/helpers/helper_functions.dart';
import 'package:virtual_assistant/utils/constants/theme/text_strings.dart';

class SpeechToTextServices {
  final SpeechToText _speechToText = SpeechToText();

  // Init Speech To Text...
  Future<void> initSpeechToText(BuildContext context) async {
    await _speechToText
        .initialize(
          onStatus: (status) => debugPrint('Status: $status'),
          onError: (error) => debugPrint('Error: $error'),
        )
        .then(<bool>(value) {
          if (!value) {
            HelperFunctions.showSnackBar(
              context: context,
              type: SnackBarType.error,
              message: AppTextStrings.onError,
            );
          }
        });
  }

  // Start Listening to the User...
  Future<String> startListening() async {
    String recognizedWords = '';

    await _speechToText.listen(
      onResult: (onSpeechResult) {
        recognizedWords = onSpeechResult.recognizedWords;
        debugPrint(recognizedWords);
      },
    );
    return recognizedWords;
  }

  // Stop Listening...
  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  /// Getting the instance of [isListening]...
  bool get isListening => _speechToText.isListening;

  /// Getting the instance of [isNotListening]...
  bool get isNotListening => _speechToText.isNotListening;

  /// Getting the instance of [hasPermission]...
  Future<bool> get hasPermission async => await _speechToText.hasPermission;
}
