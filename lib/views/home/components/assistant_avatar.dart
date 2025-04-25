import 'package:flutter/material.dart';

import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';
import 'package:voice_assistant/utils/constants/path/images_path.dart';

class AssistantAvatar extends StatelessWidget {
  const AssistantAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSizes.kAssistantAvatarRadius,
      backgroundColor: AppTheme.assistantCircleColor,
      child: Image.asset(AppImagesPath.assistantImagePath),
    );
  }
}
