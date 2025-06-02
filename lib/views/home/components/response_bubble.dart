import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/home/components/response_text.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

class ResponseBubble extends StatelessWidget {
  final String? generatedContent;

  const ResponseBubble({super.key, required this.generatedContent});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.kPadding10,
          horizontal: AppSizes.kPadding20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal:
              generatedContent != null
                  ? AppSizes.kPadding10
                  : AppSizes.kPadding40,
        ).copyWith(top: AppSizes.kPadding30),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          borderRadius: BorderRadius.circular(
            AppSizes.kGreetingContainerRadius,
          ).copyWith(topLeft: Radius.zero),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.kPadding10),
          child:
              generatedContent != null
                  ? ResponseBox(generatedContent: generatedContent!)
                  : const Text(
                    AppTextStrings.homeViewGreetingText,
                    style: TextStyle(fontSize: AppSizes.kGreetingFontSize),
                  ),
        ),
      ),
    );
  }
}
