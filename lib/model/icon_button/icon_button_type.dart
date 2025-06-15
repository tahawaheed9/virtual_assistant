import 'package:flutter/material.dart';

enum IconButtonType { speech, send }

extension IconButtonTypeConfigs on IconButtonType {
  IconData get icon {
    switch (this) {
      case IconButtonType.speech:
        return Icons.mic_outlined;

      case IconButtonType.send:
        return Icons.send_outlined;
    }
  }
}
