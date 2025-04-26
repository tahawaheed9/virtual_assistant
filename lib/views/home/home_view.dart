import 'package:flutter/material.dart';

import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/text_strings.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';
import 'package:voice_assistant/views/components/custom_app_bar.dart';
import 'package:voice_assistant/views/components/feature_box.dart';
import 'package:voice_assistant/views/home/components/features_text.dart';
import 'package:voice_assistant/views/home/components/greeting_text.dart';
import 'package:voice_assistant/views/home/components/assistant_avatar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: const Icon(Icons.menu_outlined),
        title: AppTextStrings.homeViewTitle,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AssistantAvatar(),
              GreetingText(),
              FeaturesText(),
              Column(
                children: <Widget>[
                  FeatureBox(
                    color: AppTheme.firstSuggestionBoxColor,
                    featureTitle: AppTextStrings.firstFeatureTitle,
                    featureDescription: AppTextStrings.firstFeatureDescription,
                  ),
                  FeatureBox(
                    color: AppTheme.secondSuggestionBoxColor,
                    featureTitle: AppTextStrings.secondFeatureTitle,
                    featureDescription: AppTextStrings.secondFeatureDescription,
                  ),
                  FeatureBox(
                    color: AppTheme.thirdSuggestionBoxColor,
                    featureTitle: AppTextStrings.thirdFeatureTitle,
                    featureDescription: AppTextStrings.thirdFeatureDescription,
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
