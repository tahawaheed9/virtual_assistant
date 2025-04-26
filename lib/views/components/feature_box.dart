import 'package:flutter/material.dart';

import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String featureTitle;
  final String featureDescription;

  const FeatureBox({
    super.key,
    required this.color,
    required this.featureTitle,
    required this.featureDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppSizes.kPadding10,
        horizontal: AppSizes.kPadding35,
      ),
      padding: const EdgeInsets.all(AppSizes.kPadding20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSizes.kFeatureBoxRadius),
      ),
      child: Column(
        children: <Widget>[
          // Feature Title...
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              featureTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.blackColor,
                fontFamily: AppTheme.kDefaultFontFamily,
                fontSize: AppSizes.kFeatureBoxTitleFontSize,
              ),
            ),
          ),
          const SizedBox(height: AppSizes.kSizedBoxHeight3),
          Text(
            featureDescription,
            style: const TextStyle(
              color: AppTheme.blackColor,
              fontFamily: AppTheme.kDefaultFontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
