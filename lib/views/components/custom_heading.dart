import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';

class CustomHeading extends StatelessWidget {
  final String headingTitle;

  const CustomHeading({super.key, required this.headingTitle});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          const SizedBox(height: AppSizes.kSpaceBetweenItems),
          Text(
            headingTitle,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
