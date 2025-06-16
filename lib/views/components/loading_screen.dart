import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';

class LoadingScreen extends StatelessWidget {
  final String text;

  const LoadingScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          const SizedBox(height: AppSizes.kSpaceBetweenSections),
          Text(text, style: textTheme.bodyLarge),
        ],
      ),
    );
  }
}
