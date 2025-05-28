import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:virtual_assistant/utils/constants/app_enums.dart';
import 'package:virtual_assistant/views/home/bloc/home_bloc.dart';
import 'package:virtual_assistant/views/home/bloc/home_event.dart';
import 'package:virtual_assistant/utils/helpers/helper_functions.dart';
import 'package:virtual_assistant/services/speech_to_text_services.dart';
import 'package:virtual_assistant/utils/constants/theme/text_strings.dart';

class BottomNavigationWidget extends StatefulWidget {
  final HomeBloc homeBloc;

  const BottomNavigationWidget({super.key, required this.homeBloc});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  late final SpeechToTextServices _speechToTextServices;
  late final TextEditingController _chat;

  final int animationStart = 200;
  final int animationDelay = 200;

  @override
  void initState() {
    super.initState();
    _speechToTextServices = SpeechToTextServices();
    _chat = TextEditingController();
  }

  @override
  void dispose() {
    _chat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInsets = MediaQuery.of(context).viewInsets.bottom;

    final OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).colorScheme.primary,
      ),
      borderRadius: BorderRadius.circular(50),
    );

    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        padding: EdgeInsets.only(
          top: 5.0,
          left: 8.0,
          right: 8.0,
          bottom: 5.0 + keyboardInsets,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Chat Box...
            Expanded(
              child: SlideInLeft(
                delay: Duration(
                  milliseconds: animationStart + (2 * animationDelay),
                ),
                child: TextFormField(
                  controller: _chat,
                  maxLines: null,
                  enabled: widget.homeBloc.state.isChatEnabled,
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

            // Speech Button...
            SlideInRight(
              delay: Duration(
                milliseconds: animationStart + (2 * animationDelay),
              ),
              child: IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                ),
                constraints: BoxConstraints(minWidth: 50, minHeight: 50),
                onPressed: () {
                  widget.homeBloc.add(
                    SpeechButtonPressedHomeEvent(
                      context: context,
                      isChatEnabled: widget.homeBloc.state.isChatEnabled,
                    ),
                  );
                },
                icon: Icon(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  _speechToTextServices.isListening
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

  Future<void> _onSendButtonPressed() async {
    final prompt = _chat.text.trim();
    if (prompt.isNotEmpty) {
      widget.homeBloc.add(SendButtonPressedHomeEvent(prompt: prompt));
      _chat.clear();
    } else {
      HelperFunctions.showSnackBar(
        context: context,
        type: SnackBarType.warning,
        message: AppTextStrings.onEmptyField,
      );
    }
  }
}
