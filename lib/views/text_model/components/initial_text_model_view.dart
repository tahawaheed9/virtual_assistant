import 'package:flutter/material.dart';

import 'package:virtual_assistant/views/components/feature_box.dart';
import 'package:virtual_assistant/views/components/features_text.dart';
import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/components/response_bubble.dart';
import 'package:virtual_assistant/views/components/assistant_avatar.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

class InitialTextModelView extends StatelessWidget {
  const InitialTextModelView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const PageStorageKey('home_scroll_view'),
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.kMaxWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const AssistantAvatar(),
              ResponseBubble(generatedContent: null),
              const FeaturesText(),
              Column(
                children: <Widget>[
                  FeatureBox(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    featureTitle: AppTextStrings.firstFeatureTitle,
                    featureDescription:
                        AppTextStrings.firstFeatureDescription,
                  ),
                  FeatureBox(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    featureTitle: AppTextStrings.secondFeatureTitle,
                    featureDescription:
                        AppTextStrings.secondFeatureDescription,
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
