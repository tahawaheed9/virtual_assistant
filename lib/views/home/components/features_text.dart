import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/utils/constants/theme/text_strings.dart';

class FeaturesText extends StatelessWidget {
  const FeaturesText({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(AppSizes.kPadding10),
        margin: const EdgeInsets.only(
          top: AppSizes.kPadding10,
          left: AppSizes.kPadding20,
        ),
        child: Text(
          AppTextStrings.featureHeading,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
            fontSize: AppSizes.kFeatureTextFontSize,
          ),
        ),
      ),
    );
  }
}
