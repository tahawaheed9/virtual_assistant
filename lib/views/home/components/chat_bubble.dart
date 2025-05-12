import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/text_strings.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';

class ChatBubble extends StatelessWidget {
  final String? generatedContext;
  final String? generatedImageURL;

  const ChatBubble({
    super.key,
    required this.generatedContext,
    required this.generatedImageURL,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.kPadding10),
          child:
              generatedImageURL == null
                  ? Text(
                    generatedContext == null
                        ? AppTextStrings.homeViewGreetingText
                        : generatedContext!,
                    style: TextStyle(
                      color: AppTheme.mainFontColor,
                      fontSize:
                          generatedContext == null
                              ? AppSizes.kGreetingFontSize
                              : AppSizes.kAIResponseFontSize,
                      fontFamily: AppTheme.kDefaultFontFamily,
                    ),
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSizes.kResponseImageRadius,
                    ),
                    child: Image.network(generatedImageURL!),
                  ),
        ),
      ),
    );
  }
}
