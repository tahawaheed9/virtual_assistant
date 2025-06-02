import 'package:flutter/material.dart';

import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:virtual_assistant/model/snack_bar/snack_bar_type.dart';
import 'package:virtual_assistant/utils/helpers/helper_functions.dart';
import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/views/components/custom_app_divider.dart';
import 'package:virtual_assistant/utils/constants/theme/app_text_strings.dart';

class ResponseBox extends StatelessWidget {
  final String generatedContent;

  const ResponseBox({super.key, required this.generatedContent});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppSizes.kMaxWidth),
      child: Column(
        children: <Widget>[
          GptMarkdown(
            generatedContent,
            onLinkTab: (String url, _) async {
              if (!await launchUrl(
                Uri.parse(url),
                mode: LaunchMode.platformDefault,
              )) {
                if (context.mounted) {
                  HelperFunctions.showSnackBar(
                    context: context,
                    type: SnackBarType.error,
                    message: AppTextStrings.onUnableToLaunchURL,
                  );
                }
              }
            },
          ),
          const SizedBox(height: 10.0),
          const CustomAppDivider(),
          const SizedBox(height: 10.0),
          const Text(AppTextStrings.disclaimer),
        ],
      ),
    );
  }
}
