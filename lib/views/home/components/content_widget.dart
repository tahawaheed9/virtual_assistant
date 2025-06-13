import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/home/components/response_bubble.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';
import 'package:virtual_assistant/views/home/components/assistant_avatar.dart';

class ContentWidget extends StatelessWidget {
  final String response;

  const ContentWidget({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const PageStorageKey(AppTextStrings.homeViewKey),
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
      child: Center(
        child: Column(
          children: <Widget>[
            const AssistantAvatar(),
            ResponseBubble(generatedContent: response),
          ],
        ),
      ),
    );
  }
}