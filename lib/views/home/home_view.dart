import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/text_strings.dart';
import 'package:voice_assistant/views/components/feature_box.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';
import 'package:voice_assistant/views/components/custom_app_bar.dart';
import 'package:voice_assistant/views/home/components/features_text.dart';
import 'package:voice_assistant/views/home/components/greeting_text.dart';
import 'package:voice_assistant/views/home/components/assistant_avatar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final SpeechToText _speechToText = SpeechToText();

  bool _isEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: const Icon(Icons.menu_outlined),
        title: AppTextStrings.homeViewTitle,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: AppSizes.kMaxWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                AssistantAvatar(),
                GreetingText(),
                FeaturesText(),
                Column(
                  children: <Widget>[
                    FeatureBox(
                      color: AppTheme.firstSuggestionBoxColor,
                      featureTitle: AppTextStrings.firstFeatureTitle,
                      featureDescription:
                          AppTextStrings.firstFeatureDescription,
                    ),
                    FeatureBox(
                      color: AppTheme.secondSuggestionBoxColor,
                      featureTitle: AppTextStrings.secondFeatureTitle,
                      featureDescription:
                          AppTextStrings.secondFeatureDescription,
                    ),
                    FeatureBox(
                      color: AppTheme.thirdSuggestionBoxColor,
                      featureTitle: AppTextStrings.thirdFeatureTitle,
                      featureDescription:
                          AppTextStrings.thirdFeatureDescription,
                    ),
                  ],
                ),
                Text(
                  _lastWords,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSizes.kSpaceBetweenSections),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _speechToText.isNotListening ? startListening : stopListening,
        backgroundColor: AppTheme.mainFontColor,
        child: Icon(
          color: Colors.white,
          _speechToText.isListening
              ? Icons.stop_circle_outlined
              : Icons.mic_outlined,
        ),
      ),
    );
  }

  void initSpeechToText() async {
    _isEnabled = await _speechToText.initialize(
      onStatus: (status) => debugPrint('Status: $status'),
      onError: (error) => debugPrint('Error: $error'),
    );
    setState(() {});
  }

  void startListening() async {
    await _speechToText.listen(localeId: 'en_US', onResult: onSpeechResult);
    setState(() {});
  }

  void stopListening() async {
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
