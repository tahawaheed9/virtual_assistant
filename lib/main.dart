import 'package:flutter/material.dart';

import 'package:voice_assistant/views/home_view.dart';
import 'package:voice_assistant/utils/constants/text_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTextStrings.appTitle,
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
