import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:voice_assistant/services/ai_services.dart';
import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/text_strings.dart';
import 'package:voice_assistant/views/components/feature_box.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';
import 'package:voice_assistant/views/components/custom_app_bar.dart';
import 'package:voice_assistant/views/home/components/features_text.dart';
import 'package:voice_assistant/views/home/components/chat_bubble.dart';
import 'package:voice_assistant/views/home/components/assistant_avatar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final SpeechToText _speechToText = SpeechToText();
  final AIServices _aiServices = AIServices();

  String _lastWords = '';

  String? generatedContent;
  String? generatedImageURL;

  final int animationStart = 200;
  final int animationDelay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  @override
  void dispose() {
    _speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppTextStrings.homeViewTitle),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppSizes.kMaxWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const AssistantAvatar(),
                ChatBubble(
                  generatedContent: generatedContent,
                  generatedImageURL: generatedImageURL,
                ),
                FeaturesText(
                  generatedContent: generatedContent,
                  generatedImageURL: generatedImageURL,
                ),
                Visibility(
                  visible:
                      generatedContent == null && generatedImageURL == null,
                  child: Column(
                    children: <Widget>[
                      SlideInLeft(
                        delay: Duration(milliseconds: animationStart),
                        child: const FeatureBox(
                          color: AppTheme.firstSuggestionBoxColor,
                          featureTitle: AppTextStrings.firstFeatureTitle,
                          featureDescription:
                              AppTextStrings.firstFeatureDescription,
                        ),
                      ),
                      SlideInRight(
                        delay: Duration(
                          milliseconds: animationStart + animationDelay,
                        ),
                        child: const FeatureBox(
                          color: AppTheme.secondSuggestionBoxColor,
                          featureTitle: AppTextStrings.secondFeatureTitle,
                          featureDescription:
                              AppTextStrings.secondFeatureDescription,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.kSpaceBetweenSections),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: animationStart + (2 * animationDelay)),
        child: FloatingActionButton(
          onPressed: () async {
            await onSpeechButtonPressed();
          },
          backgroundColor: AppTheme.mainFontColor,
          child: Icon(
            color: Colors.white,
            _speechToText.isListening
                ? Icons.stop_circle_outlined
                : Icons.mic_outlined,
          ),
        ),
      ),
    );
  }

  Future<void> onSpeechButtonPressed() async {
    if (await _speechToText.hasPermission && _speechToText.isNotListening) {
      await startListening();
    } else if (_speechToText.isListening) {
      final response = await _aiServices.getAIModelResponse(_lastWords);
      if (response.isNotEmpty) {
        setState(() {
          generatedContent = response;
          generatedImageURL = null;
        });
      }
      await stopListening();
    } else {
      await initSpeechToText();
    }
  }

  Future<void> initSpeechToText() async {
    await _speechToText.initialize(
      onStatus: (status) => debugPrint('Status: $status'),
      onError: (error) => debugPrint('Error: $error'),
    );
    setState(() {});
  }

  Future<void> startListening() async {
    await _speechToText.listen(localeId: 'en_US', onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      debugPrint('Recognized Words: $_lastWords');
    });
  }
}
