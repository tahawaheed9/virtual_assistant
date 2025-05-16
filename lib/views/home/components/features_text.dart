import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/text_strings.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';

class FeaturesText extends StatelessWidget {
  final String? generatedContent;
  final String? generatedImageURL;

  const FeaturesText({
    super.key,
    required this.generatedContent,
    this.generatedImageURL,
  });

  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      child: Visibility(
        visible: generatedContent == null && generatedImageURL == null,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(AppSizes.kPadding10),
          margin: const EdgeInsets.only(
            top: AppSizes.kPadding10,
            left: AppSizes.kPadding20,
          ),
          child: const Text(
            AppTextStrings.featureHeading,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.mainFontColor,
              fontSize: AppSizes.kFeatureTextFontSize,
              fontFamily: AppTheme.kDefaultFontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
