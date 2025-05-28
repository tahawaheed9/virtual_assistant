import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:virtual_assistant/utils/constants/theme/app_sizes.dart';
import 'package:virtual_assistant/utils/constants/theme/text_strings.dart';

class ChatBubble extends StatelessWidget {
  final String? generatedContent;

  const ChatBubble({super.key, required this.generatedContent});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.kPadding10,
          horizontal: AppSizes.kPadding20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal:
              generatedContent != null
                  ? AppSizes.kPadding10
                  : AppSizes.kPadding40,
        ).copyWith(top: AppSizes.kPadding30),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          borderRadius: BorderRadius.circular(
            AppSizes.kGreetingContainerRadius,
          ).copyWith(topLeft: Radius.zero),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.kPadding10),
          child:
              generatedContent != null
                  ? ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: AppSizes.kMaxWidth),
                    child: Column(
                      children: <Widget>[
                        MarkdownBody(
                          data: generatedContent!,
                          styleSheet: MarkdownStyleSheet.fromTheme(
                            Theme.of(context),
                          ).copyWith(p: Theme.of(context).textTheme.bodyLarge),
                        ),
                        const SizedBox(height: 10.0),
                        Divider(
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        const SizedBox(height: 10.0),
                        const Text(AppTextStrings.disclaimer),
                      ],
                    ),
                  )
                  : Text(
                    AppTextStrings.homeViewGreetingText,
                    style: TextStyle(fontSize: AppSizes.kGreetingFontSize),
                  ),
        ),
      ),
    );
  }
}
