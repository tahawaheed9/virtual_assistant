import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:virtual_assistant/views/components/feature_box.dart';
import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/home/components/features_text.dart';
import 'package:virtual_assistant/views/home/components/response_bubble.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';
import 'package:virtual_assistant/views/home/components/assistant_avatar.dart';

class InitialHome extends StatelessWidget {
  const InitialHome({super.key});

  @override
  Widget build(BuildContext context) {
    final int animationStart = 200;
    final int animationDelay = 200;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppSizes.kMaxWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const AssistantAvatar(),
              ResponseBubble(generatedContent: null),
              const FeaturesText(),
              Column(
                children: <Widget>[
                  SlideInLeft(
                    delay: Duration(milliseconds: animationStart),
                    child: FeatureBox(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      featureTitle: AppTextStrings.firstFeatureTitle,
                      featureDescription: AppTextStrings.firstFeatureDescription,
                    ),
                  ),
                  SlideInRight(
                    delay: Duration(milliseconds: animationStart + animationDelay),
                    child: FeatureBox(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      featureTitle: AppTextStrings.secondFeatureTitle,
                      featureDescription: AppTextStrings.secondFeatureDescription,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
