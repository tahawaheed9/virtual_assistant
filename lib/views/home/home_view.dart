import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:voice_assistant/utils/constants/app_enums.dart';
import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/text_strings.dart';
import 'package:voice_assistant/utils/helpers/helper_functions.dart';
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

  String _lastWords = '';

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
                Visibility(
                  visible: _lastWords.isNotEmpty,
                  child: Text(
                    _lastWords,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.mainFontColor,
        icon: Icon(
          color: Colors.white,
          _speechToText.isListening
              ? Icons.stop_circle_outlined
              : Icons.mic_outlined,
        ),
        label: Text(
          'Tap to speak...',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
        onPressed: onButtonPressed,
      ),
    );
  }

  Future<void> initSpeechToText() async {
    await _speechToText.initialize();
    setState(() {});
    HelperFunctions.showSnackbar(
      context: context,
      type: SnackBarType.success,
      message: 'Tap the microphone and speak...',
    );
  }

  Future<void> startListening() async {
    await _speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  Future<void> onButtonPressed() async {
    final hasPermission = await _speechToText.hasPermission;

    if (!hasPermission) {
      await initSpeechToText();
      return;
    }

    if (_speechToText.isListening) {
      await stopListening();
    } else {
      await startListening();
    }
  }
}
