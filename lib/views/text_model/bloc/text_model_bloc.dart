import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/services/ai_services.dart';
import 'package:virtual_assistant/services/speech_to_text_services.dart';
import 'package:virtual_assistant/views/text_model/bloc/text_model_event.dart';
import 'package:virtual_assistant/views/text_model/bloc/text_model_state.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

class TextModelBloc extends Bloc<TextModelEvent, TextModelState> {
  final SpeechToTextServices _speechToTextServices = SpeechToTextServices();
  final AIServices _aiServices = AIServices();

  TextModelBloc() : super(const InitialTextModelState()) {
    // Initially when the app starts...
    on<InitialTextModelEvent>((event, emit) async {
      final isSpeechEnabled = await _speechToTextServices.initSpeechToText();
      if (isSpeechEnabled) {
        emit(const InitialTextModelState());
      } else {
        emit(const ErrorTextModelState(error: AppTextStrings.onSpeechError));
        return;
      }
    });

    // Triggers when speech button is pressed...
    on<SpeechButtonPressedTextModelEvent>((event, emit) async {
      // If speech to text has permission and is not listening...
      if (await _speechToTextServices.hasPermission &&
          _speechToTextServices.isNotListening) {
        emit(const ListeningTextModelState());

        await _speechToTextServices.startListening();
      }
      // If speech to text is listening get the recognized words...
      else if (_speechToTextServices.isListening) {
        // Stop speech to text...
        await _speechToTextServices.stopListening();

        await Future.delayed(const Duration(milliseconds: 500));
        // Getting the recognized words...
        final recognizedWords = _speechToTextServices.getRecognizedWords;
        debugPrint('Bloc: $recognizedWords');
        if (recognizedWords.isEmpty) {
          emit(
            const ErrorTextModelState(
              error: AppTextStrings.onSpeechNotRecognized,
            ),
          );
          return;
        }

        // Show loading screen while fetching the response...
        emit(const GeneratingResponseTextModelState());

        // Response fetched...
        final response = await _aiServices.getAIModelResponse(recognizedWords);

        // Load the response...
        if (response.isNotEmpty) {
          emit(LoadedTextModelState(response: response));
        } else {
          emit(const ErrorTextModelState(error: AppTextStrings.onNullResponse));
          return;
        }
      } else {
        await _speechToTextServices.initSpeechToText();
      }
    });

    // Triggers when the send button is pressed...
    on<SendButtonPressedTextModelEvent>((event, emit) async {
      emit(const GeneratingResponseTextModelState());
      final response = await _aiServices.getAIModelResponse(event.prompt);
      if (response.isNotEmpty) {
        emit(LoadedTextModelState(response: response));
      } else {
        emit(const ErrorTextModelState(error: AppTextStrings.onNullResponse));
      }
    });
  }
}
