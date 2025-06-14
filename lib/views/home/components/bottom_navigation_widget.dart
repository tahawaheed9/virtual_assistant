import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:virtual_assistant/views/home/bloc/home_bloc.dart';
import 'package:virtual_assistant/views/home/bloc/home_event.dart';
import 'package:virtual_assistant/views/home/bloc/home_state.dart';
import 'package:virtual_assistant/model/snack_bar/snack_bar_type.dart';
import 'package:virtual_assistant/utils/helpers/helper_functions.dart';
import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

class BottomNavigationWidget extends StatefulWidget {
  final HomeBloc homeBloc;

  const BottomNavigationWidget({super.key, required this.homeBloc});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  late final TextEditingController _promptController;

  final int animationStart = 200;
  final int animationDelay = 200;

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController();
  }

  @override
  void dispose() {
    _promptController.dispose();
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
          top: AppSizes.kVertical,
          left: AppSizes.kHorizontal,
          right: AppSizes.kHorizontal,
          bottom: AppSizes.kVertical + keyboardInsets,
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
                child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: widget.homeBloc,
                  builder: (context, state) {
                    return TextFormField(
                      controller: _promptController,
                      maxLines: null,
                      enabled: state.isChatEnabled,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (_) => _onSendButtonPressed(),
                      decoration: InputDecoration(
                        hintText: AppTextStrings.textFieldHint,
                        focusedBorder: textFieldBorder,
                        border: textFieldBorder,
                        prefixIcon: Icon(
                          Icons.chat_outlined,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: _onSendButtonPressed,
                          child: Tooltip(
                            message: AppTextStrings.sendButtonText,
                            child: Icon(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                              Icons.send_outlined,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: AppSizes.kSnackBarSpaceBetweenItems),

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
                constraints: const BoxConstraints(
                  minWidth: AppSizes.kMinSizeSpeechButton,
                  minHeight: AppSizes.kMinSizeSpeechButton,
                ),
                onPressed: _onSpeechButtonPressed,
                icon: BlocBuilder<HomeBloc, HomeState>(
                  bloc: widget.homeBloc,
                  builder: (context, state) {
                    return Icon(
                      state is ListeningHomeState
                          ? Icons.stop_circle_outlined
                          : Icons.mic_outlined,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSendButtonPressed() {
    final prompt = _promptController.text.trim();
    if (prompt.isNotEmpty) {
      widget.homeBloc.add(SendButtonPressedHomeEvent(prompt: prompt));
      _promptController.clear();
    } else {
      HelperFunctions.showSnackBar(
        context: context,
        snackBarType: SnackBarType.warning,
        message: AppTextStrings.onEmptyField,
      );
      return;
    }
  }

  void _onSpeechButtonPressed() {
    widget.homeBloc.add(const SpeechButtonPressedHomeEvent());
  }
}
