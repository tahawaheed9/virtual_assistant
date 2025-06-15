import 'package:flutter/material.dart';

import 'package:virtual_assistant/views/home/bloc/home_bloc.dart';
import 'package:virtual_assistant/views/home/bloc/home_event.dart';
import 'package:virtual_assistant/views/home/bloc/home_state.dart';
import 'package:virtual_assistant/model/snack_bar/snack_bar_type.dart';
import 'package:virtual_assistant/utils/helpers/helper_functions.dart';
import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/model/icon_button/icon_button_type.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

class BottomNavigationWidget extends StatefulWidget {
  final HomeBloc homeBloc;
  final HomeState homeState;

  const BottomNavigationWidget({
    super.key,
    required this.homeBloc,
    required this.homeState,
  });

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  late final TextEditingController _promptController;

  bool _textFieldHasText = false;

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController();
    _promptController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _promptController.removeListener(_onTextChanged);
    _promptController.dispose();
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
                enabled: widget.homeState.isChatEnabled,
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

            _textFieldHasText
                ? HelperFunctions.buildIconButton(
                  homeState: null,
                  context: context,
                  onPressed: _onSendButtonPressed,
                  iconButtonType: IconButtonType.send,
                )
                : HelperFunctions.buildIconButton(
                  homeState: widget.homeState,
                  context: context,
                  onPressed: _onSpeechButtonPressed,
                  iconButtonType: IconButtonType.speech,
                ),
          ],
        ),
      ),
    );
  }

  void _onTextChanged() {
    setState(() {
      _textFieldHasText = _promptController.text.trim().isNotEmpty;
    });
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
