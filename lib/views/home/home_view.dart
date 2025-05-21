import 'dart:async';

import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:virtual_assistant/services/ai_services.dart';
import 'package:virtual_assistant/utils/constants/app_enums.dart';
import 'package:virtual_assistant/views/components/feature_box.dart';
import 'package:virtual_assistant/utils/helpers/helper_functions.dart';
import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/components/custom_app_bar.dart';
import 'package:virtual_assistant/views/home/components/app_drawer.dart';
import 'package:virtual_assistant/views/home/components/chat_bubble.dart';
import 'package:virtual_assistant/utils/constants/theme/text_strings.dart';
import 'package:virtual_assistant/views/home/components/features_text.dart';
import 'package:virtual_assistant/views/home/components/assistant_avatar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SpeechToText _speechToText = SpeechToText();
  final AIServices _aiServices = AIServices();

  String _lastWords = '';
  bool _isChatEnabled = true;
  late final TextEditingController _chat;

  String? generatedContent;
  String? generatedImageURL;

  final int animationStart = 200;
  final int animationDelay = 200;

  @override
  void initState() {
    super.initState();
    _initSpeechToText();
    _chat = TextEditingController();
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
      key: _scaffoldKey,
      appBar: CustomAppBar(
        leading: IconButton(
          tooltip: 'Open drawer',
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          icon: Icon(
            Icons.menu_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: BounceIn(child: const Text(AppTextStrings.homeViewTitle)),
      ),
      drawer: AppDrawer(),
      drawerEnableOpenDragGesture: false,
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
                        child: FeatureBox(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          featureTitle: AppTextStrings.firstFeatureTitle,
                          featureDescription:
                              AppTextStrings.firstFeatureDescription,
                        ),
                      ),
                      SlideInRight(
                        delay: Duration(
                          milliseconds: animationStart + animationDelay,
                        ),
                        child: FeatureBox(
                          color: Theme.of(context).colorScheme.inversePrimary,
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
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).colorScheme.primary,
      ),
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
                    prefixIcon: Icon(
                      Icons.chat_outlined,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () async => _onSendButtonPressed(),
                      child: Tooltip(
                        message: AppTextStrings.sendButtonText,
                        child: Icon(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          Icons.send_outlined,
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
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                constraints: BoxConstraints(minHeight: 50, minWidth: 50),
                onPressed: () async => _onSpeechButtonPressed(),
                icon: Icon(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
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
