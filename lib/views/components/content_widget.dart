import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/components/response_bubble.dart';
import 'package:virtual_assistant/views/components/assistant_avatar.dart';

class ContentWidget extends StatelessWidget {
  final String response;

  const ContentWidget({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
      children: <Widget>[
        const AssistantAvatar(),
        ResponseBubble(generatedContent: response),
      ],
    );
  }
}
