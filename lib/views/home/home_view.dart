import 'dart:async';

import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:voice_assistant/services/ai_services.dart';
import 'package:voice_assistant/utils/constants/app_enums.dart';
import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/text_strings.dart';
import 'package:voice_assistant/utils/helpers/helper_functions.dart';
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

  bool _isChatEnabled = true;

  final TextEditingController _chat = TextEditingController();

  String _lastWords = '';

  String? generatedContent;
  String? generatedImageURL;

  final int animationStart = 200;
  final int animationDelay = 200;

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
  }

  @override
  void dispose() {
    _speechToText.stop();
    _chat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInsets = MediaQuery.of(context).viewInsets.bottom;
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
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _buildBottomWidget(keyboardInsets),
    );
  }

  Future<void> _onSpeechButtonPressed() async {
    _isChatEnabled = false;
    if (await _speechToText.hasPermission && _speechToText.isNotListening) {
      await _startListening();
    } else if (_speechToText.isListening) {
      final response = await _aiServices.getAIModelResponse(_lastWords);
      if (response.isNotEmpty) {
        generatedContent = response;
        generatedImageURL = null;
      }
      _isChatEnabled = true;
      await _stopListening();
    } else {
      await _initSpeechToText();
    }
  }

  Future<void> _onSendButtonPressed() async {
    final prompt = _chat.text.trim();
    if (prompt.isNotEmpty) {
      final response = await _aiServices.getAIModelResponse(prompt);
      _chat.clear();
      if (response.isNotEmpty) {
        generatedContent = response;
        generatedImageURL = null;
        setState(() {});
      }
    } else {
      HelperFunctions.showSnackbar(
        context: context,
        type: SnackBarType.warning,
        message: AppTextStrings.onEmptyField,
      );
    }
  }

  Future<void> _initSpeechToText() async {
    await _speechToText
        .initialize(
          onStatus: (status) => debugPrint('Status: $status'),
          onError: (error) => debugPrint('Error: $error'),
        )
        .then(<bool>(value) {
          if (value) {
            HelperFunctions.showSnackbar(
              context: context,
              type: SnackBarType.success,
              message: AppTextStrings.onSpeechAvailable,
            );
          } else {
            HelperFunctions.showSnackbar(
              context: context,
              type: SnackBarType.error,
              message: AppTextStrings.onError,
            );
          }
        });
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(localeId: 'en_US', onResult: _onSpeechResult);
    setState(() {});
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  SafeArea _buildBottomWidget(double keyboardInsets) {
    final textFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: AppTheme.mainFontColor),
    );
    return SafeArea(
      top: false,
      bottom: true,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSizes.kDefaultPadding,
          left: AppSizes.kDefaultPadding,
          right: AppSizes.kDefaultPadding,
          bottom: AppSizes.kDefaultPadding + keyboardInsets,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SlideInLeft(
                delay: Duration(
                  milliseconds: animationStart + (2 * animationDelay),
                ),
                child: Form(
                  child: TextFormField(
                    controller: _chat,
                    maxLines: null,
                    enabled: _isChatEnabled,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      hintText: AppTextStrings.textFieldHint,
                      focusedBorder: textFieldBorder,
                      border: textFieldBorder,
                      prefixIcon: const Icon(
                        Icons.chat_outlined,
                        color: AppTheme.mainFontColor,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () async => _onSendButtonPressed(),
                        child: const Tooltip(
                          message: AppTextStrings.sendButtonText,
                          child: Icon(
                            color: AppTheme.mainFontColor,
                            Icons.send_outlined,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            SlideInRight(
              delay: Duration(
                milliseconds: animationStart + (2 * animationDelay),
              ),
              child: IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.mainFontColor,
                ),
                constraints: BoxConstraints(minHeight: 50, minWidth: 50),
                onPressed: () async => _onSpeechButtonPressed(),
                icon: Icon(
                  color: Colors.white,
                  _speechToText.isListening
                      ? Icons.stop_circle_outlined
                      : Icons.mic_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
