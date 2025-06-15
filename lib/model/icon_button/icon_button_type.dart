import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

enum IconButtonType { speech, stop, send }

extension IconButtonTypeConfigs on IconButtonType {
  String? get toolTip {
    switch (this) {
      case IconButtonType.speech:
        return AppTextStrings.speakButtonTooltip;

      case IconButtonType.send:
        return AppTextStrings.sendButtonTooltip;

      default:
        return AppTextStrings.stopButtonTooltip;
    }
  }

  IconData get icon {
    switch (this) {
      case IconButtonType.speech:
        return Icons.mic_outlined;

      case IconButtonType.send:
        return Icons.send_outlined;

      default:
        return Icons.stop_circle_outlined;
    }
  }
}
