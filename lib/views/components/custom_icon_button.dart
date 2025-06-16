import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/model/icon_button/icon_button_type.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconButtonType iconButtonType;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.iconButtonType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton.filled(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
      ),
      constraints: const BoxConstraints(
        minWidth: AppSizes.kMinSizeIconButton,
        minHeight: AppSizes.kMinSizeIconButton,
      ),
      icon: Icon(iconButtonType.icon, color: colorScheme.onPrimaryContainer),
    );
  }
}
