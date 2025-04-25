import 'package:flutter/material.dart';

import 'package:voice_assistant/utils/constants/text_strings.dart';
import 'package:voice_assistant/views/components/custom_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: AppTextStrings.homeViewTitle));
  }
}
