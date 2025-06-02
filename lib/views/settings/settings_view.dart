import 'package:flutter/material.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/components/custom_app_bar.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';
import 'package:virtual_assistant/views/settings/components/appearance_settings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text(AppTextStrings.settingsAppBarTitle),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.kDefaultPadding),
        child: Center(child: Column(children: <Widget>[AppearanceSettings()])),
      ),
    );
  }
}
