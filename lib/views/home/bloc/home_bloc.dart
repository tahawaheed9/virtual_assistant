import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/services/ai_services.dart';
import 'package:virtual_assistant/views/home/bloc/home_event.dart';
import 'package:virtual_assistant/views/home/bloc/home_state.dart';
import 'package:virtual_assistant/services/speech_to_text_services.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SpeechToTextServices _speechToTextServices = SpeechToTextServices();
  final AIServices _aiServices = AIServices();

  HomeBloc() : super(const InitialHomeState()) {
    // Initially when the app starts...
    on<InitialHomeEvent>((event, emit) async {
      final isSpeechEnabled = await _speechToTextServices.initSpeechToText();
      if (isSpeechEnabled) {
        emit(const InitialHomeState());
      } else {
        emit(const ErrorHomeState(error: AppTextStrings.onSpeechError));
      }
    });

    // Triggers when speech button is pressed...
    on<SpeechButtonPressedHomeEvent>((event, emit) async {
      // If speech to text has permission and is not listening...
      if (await _speechToTextServices.hasPermission &&
          _speechToTextServices.isNotListening) {
        emit(const ListeningHomeState());
        await _speechToTextServices.startListening();
      }
      // If speech to text is listening get the recognized words...
      else if (_speechToTextServices.isListening) {
        // Stop speech to text...
        await _speechToTextServices.stopListening();

        // Show loading screen while fetching the response...
        emit(const LoadingHomeState());

        // Response fetched...
        final response = await _aiServices.getAIModelResponse('');

        // Load the response...
        if (response.isNotEmpty) {
          emit(LoadedHomeState(response: response));
        } else {
          emit(const ErrorHomeState(error: AppTextStrings.onNullResponse));
        }
      } else {
        await _speechToTextServices.initSpeechToText();
      }
    });

    // Triggers when the send button is pressed...
    on<SendButtonPressedHomeEvent>((event, emit) async {
      emit(const LoadingHomeState());
      final response = await _aiServices.getAIModelResponse(event.prompt);
      if (response.isNotEmpty) {
        emit(LoadedHomeState(response: response));
      } else {
        emit(const ErrorHomeState(error: AppTextStrings.onNullResponse));
      }
    });
  }
}
