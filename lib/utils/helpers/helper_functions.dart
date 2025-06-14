import 'package:flutter/material.dart';

import 'package:virtual_assistant/model/snack_bar/snack_bar_type.dart';
import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

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
            AppTextStrings.onGeneratingResponse,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showSnackBar({
    required BuildContext context,
    required SnackBarType snackBarType,
    required String message,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: snackBarType.backgroundColor(context),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(AppSizes.kSnackBarContentPadding),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.kSnackBarBorderRadius),
        ),
        content: Row(
          children: <Widget>[
            Icon(snackBarType.icon, color: snackBarType.iconColor),
            const SizedBox(width: AppSizes.kSnackBarSpaceBetweenItems),
            Flexible(
              child: Text(message, style: TextStyle(color: snackBarType.textColor)),
            ),
          ],
        ),
      ),
    );
  }
}
