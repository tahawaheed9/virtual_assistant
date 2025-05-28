import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/app_enums.dart';
import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';

class HelperFunctions {
  HelperFunctions._();

  static Widget showLoadingScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: AppSizes.kSpaceBetweenSections),
          Text(
            'Generating Response...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showSnackBar({
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
                : Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(AppSizes.kSnackBarContentPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.kSnackBarBorderRadius),
        ),
        content: Row(
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
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
