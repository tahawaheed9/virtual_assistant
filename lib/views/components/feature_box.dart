import 'package:flutter/material.dart';

import 'package:voice_assistant/utils/constants/app_sizes.dart';
import 'package:voice_assistant/utils/constants/theme/app_theme.dart';

class FeatureBox extends StatefulWidget {
  final Color color;
  final String featureTitle;
  final String featureDescription;

  const FeatureBox({
    super.key,
    required this.color,
    required this.featureTitle,
    required this.featureDescription,
  });

  @override
  State<FeatureBox> createState() => _FeatureBoxState();
}

class _FeatureBoxState extends State<FeatureBox> {
  bool _isExpanded = false;
  bool _isOverflowing = false;

  final _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Wait for the first frame to be rendered before checking overflow...
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final textRenderBox =
          _textKey.currentContext?.findRenderObject() as RenderBox?;
      if (textRenderBox != null) {
        // Checking if the text is overflowing...
        final isOverflowing = _checkTextOverflow();
        if (isOverflowing != _isOverflowing) {
          setState(() {
            _isOverflowing = isOverflowing;
          });
        }
      }
    });
  }

  bool _checkTextOverflow() {
    final span = TextSpan(text: widget.featureDescription);

    final tp = TextPainter(
      text: span,
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );

    tp.layout(
      maxWidth:
          MediaQuery.of(context).size.width - AppSizes.kPadding35 * 2 - 48,
    ); // Adjust for padding and icon
    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppSizes.kPadding10,
        horizontal: AppSizes.kPadding35,
      ),
      padding: const EdgeInsets.all(AppSizes.kPadding20),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(AppSizes.kFeatureBoxRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.featureTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.blackColor,
                    fontFamily: AppTheme.kDefaultFontFamily,
                    fontSize: AppSizes.kFeatureBoxTitleFontSize,
                  ),
                ),
                const SizedBox(height: AppSizes.kSizedBoxHeight3),
                Text(
                  widget.featureDescription,
                  key: _textKey,
                  maxLines: _isExpanded ? null : 2,
                  overflow:
                      _isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.blackColor,
                    fontFamily: AppTheme.kDefaultFontFamily,
                  ),
                ),
              ],
            ),
          ),
          if (_isOverflowing)
            IconButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              tooltip: _isExpanded ? 'Collapse' : 'Expand',
              icon: Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
            ),
        ],
      ),
    );
  }
}
