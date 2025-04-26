import 'package:flutter/material.dart';

import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/text_strings.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';

class FeaturesText extends StatelessWidget {
  const FeaturesText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(AppSizes.kPadding10),
      margin: const EdgeInsets.only(
        top: AppSizes.kPadding10,
        left: AppSizes.kPadding20,
      ),
      child: const Text(
        AppTextStrings.featureText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.mainFontColor,
          fontSize: AppSizes.kFeatureTextFontSize,
          fontFamily: AppTheme.kDefaultFontFamily,
        ),
      ),
    );
  }
}
