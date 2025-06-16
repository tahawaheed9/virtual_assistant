import 'package:flutter/material.dart';

enum IconButtonType { speech, stop, send }

extension IconButtonTypeConfigs on IconButtonType {
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
