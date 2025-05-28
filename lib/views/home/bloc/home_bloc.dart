import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/services/ai_services.dart';
import 'package:virtual_assistant/views/home/bloc/home_event.dart';
import 'package:virtual_assistant/views/home/bloc/home_state.dart';
import 'package:virtual_assistant/services/speech_to_text_services.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SpeechToTextServices _speechToTextServices;
  final AIServices _aiServices;

  HomeBloc(SpeechToTextServices speechToTextServices, AIServices aiServices)
    : _speechToTextServices = speechToTextServices,
      _aiServices = aiServices,
      super(const InitialHomeState()) {
    // Initially when the app starts...
    on<InitialHomeEvent>((event, emit) async {
      await _speechToTextServices.initSpeechToText(event.context);
      emit(const InitialHomeState());
    });

    // Triggers when speech button is pressed...
    on<SpeechButtonPressedHomeEvent>((event, emit) async {
      String recognizedWords = '';

      // Disabling the chat while speech to text is enabled...
      event.isChatEnabled = !event.isChatEnabled;

      // If speech to text has permission and is not listening...
      if (await _speechToTextServices.hasPermission &&
          _speechToTextServices.isNotListening) {
        recognizedWords = await _speechToTextServices.startListening();
      }
      // If speech to text is listening get the recognized words...
      else if (_speechToTextServices.isListening) {
        // Show loading screen while fetching the response...
        emit(const LoadingHomeState());

        // Response fetched...
        final response = await _aiServices.getAIModelResponse(recognizedWords);

        // Load the response...
        if (response.isNotEmpty) {
          emit(LoadedHomeState(response: response));
        } else {
          emit(ErrorHomeState(error: 'Could not fetch the response.'));
        }

        // Enable the chat for the user...
        event.isChatEnabled = event.isChatEnabled;

        // Stop speech to text...
        await _speechToTextServices.stopListening();
      } else {
        await _speechToTextServices.initSpeechToText(event.context);
      }
    });

    // Triggers when the send button is pressed...
    on<SendButtonPressedHomeEvent>((event, emit) async {
      emit(const LoadingHomeState());
      final response = await _aiServices.getAIModelResponse(event.prompt);
      if (response.isNotEmpty) {
        emit(LoadedHomeState(response: response));
      } else {
        emit(ErrorHomeState(error: 'Could not fetch the response.'));
      }
    });
  }
}
