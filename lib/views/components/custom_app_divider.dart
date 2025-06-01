import 'package:flutter/material.dart';

class CustomAppDivider extends StatelessWidget {
  const CustomAppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: Theme.of(context).colorScheme.primaryContainer);
  }
}
