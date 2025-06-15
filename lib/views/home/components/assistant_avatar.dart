import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/utils/constants/assets_path/images_path.dart';

class AssistantAvatar extends StatelessWidget {
  const AssistantAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSizes.kAssistantAvatarRadius,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      child: Image.asset(AppImagesPath.assistantImagePath),
    );
  }
}
