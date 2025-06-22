import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/model/icon_button/icon_button_type.dart';
import 'package:virtual_assistant/views/components/custom_icon_button.dart';
import 'package:virtual_assistant/views/text_model/bloc/text_model_bloc.dart';
import 'package:virtual_assistant/views/text_model/bloc/text_model_event.dart';
import 'package:virtual_assistant/views/text_model/bloc/text_model_state.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

class BottomNavigationWidget extends StatefulWidget {
  final TextModelBloc bloc;
  final TextModelState state;

  const BottomNavigationWidget({
    super.key,
    required this.bloc,
    required this.state,
  });

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  late final TextEditingController _promptController;

  late final ValueNotifier<bool> _textFieldHasData;

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController();
    _textFieldHasData = ValueNotifier(false);
    _promptController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _promptController.removeListener(_onTextChanged);
    _promptController.dispose();
    _textFieldHasData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInsets = MediaQuery.of(context).viewInsets.bottom;

    final OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: AppSizes.kTextFieldBorderWidth,
        color: Theme.of(context).colorScheme.primary,
      ),
      borderRadius: BorderRadius.circular(AppSizes.kTextFieldRadius),
    );

    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: AppSizes.kMaxHeight + keyboardInsets,
        ),
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
              child: TextFormField(
                controller: _promptController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                enabled: widget.state.isChatEnabled,
                decoration: InputDecoration(
                  hintText: AppTextStrings.textFieldHint,
                  focusedBorder: textFieldBorder,
                  border: textFieldBorder,
                  prefixIcon: Icon(
                    Icons.chat_outlined,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSizes.kSnackBarSpaceBetweenItems),

            ValueListenableBuilder(
              valueListenable: _textFieldHasData,
              builder: (context, textFieldHasData, child) {
                return CustomIconButton(
                  onPressed:
                      textFieldHasData
                          ? _onSendButtonPressed
                          : _onSpeechButtonPressed,
                  iconButtonType:
                      textFieldHasData
                          ? IconButtonType.send
                          : widget.state is ListeningTextModelState
                          ? IconButtonType.stop
                          : IconButtonType.speech,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onTextChanged() {
    _textFieldHasData.value = _promptController.text.trim().isNotEmpty;
  }

  void _onSendButtonPressed() {
    final prompt = _promptController.text.trim();
    widget.bloc.add(SendButtonPressedTextModelEvent(prompt: prompt));
    _promptController.clear();
  }

  void _onSpeechButtonPressed() {
    widget.bloc.add(const SpeechButtonPressedTextModelEvent());
  }
}
