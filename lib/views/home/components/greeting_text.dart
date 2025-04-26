import 'package:flutter/material.dart';

import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/text_strings.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.kPadding10,
        horizontal: AppSizes.kPadding20,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.kPadding40,
      ).copyWith(top: AppSizes.kPadding30),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(
          AppSizes.kGreetingContainerRadius,
        ).copyWith(topLeft: Radius.zero),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.kPadding10),
        child: Text(
          AppTextStrings.homeViewGreetingText,
          style: TextStyle(
            color: AppTheme.mainFontColor,
            fontSize: AppSizes.kGreetingFontSize,
            fontFamily: AppTheme.kDefaultFontFamily,
          ),
        ),
      ),
    );
  }
}
