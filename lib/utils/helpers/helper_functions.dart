import 'package:flutter/material.dart';

import 'package:voice_assistant/utils/constants/app_enums.dart';
import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';

class HelperFunctions {
  HelperFunctions._();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showSnackbar({
    required BuildContext context,
    required SnackBarType type,
    required String message,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            type == SnackBarType.success
                ? Colors.green[800]
                : type == SnackBarType.warning
                ? Colors.orange[800]
                : Colors.red[800],
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(AppSizes.kSnackBarContentPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.kSnackBarBorderRadius),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              color: Colors.white,
              type == SnackBarType.success
                  ? Icons.check_circle_outline
                  : type == SnackBarType.warning
                  ? Icons.warning_amber_rounded
                  : Icons.error_outline,
            ),
            const SizedBox(width: AppSizes.kSnackBarSpaceBetweenItems),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: AppTheme.kDefaultFontFamily,
                ),
              ),
            ),
          ],
        ),
        showCloseIcon: true,
      ),
    );
  }
}
