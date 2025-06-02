import 'package:flutter/material.dart';

enum SnackBarType { general, success, warning, error }

extension SnackBarTypeConfigs on SnackBarType {
  Color backgroundColor(BuildContext context) {
    switch (this) {
      case SnackBarType.general:
        return const Color(0xff284777);

      case SnackBarType.success:
        return Colors.green.shade800;

      case SnackBarType.warning:
        return Colors.orange.shade800;

      case SnackBarType.error:
        return Theme.of(context).colorScheme.errorContainer;
    }
  }

  Color get textColor {
    switch (this) {
      case SnackBarType.general:
      case SnackBarType.success:
      case SnackBarType.warning:
      case SnackBarType.error:
        return Colors.white;
    }
  }

  IconData get icon {
    switch (this) {
      case SnackBarType.general:
        return Icons.info_outline;

      case SnackBarType.success:
        return Icons.check_circle_outline;

      case SnackBarType.warning:
        return Icons.warning_amber_rounded;

      case SnackBarType.error:
        return Icons.error_outline;
    }
  }

  Color get iconColor {
    return Colors.white;
  }
}
