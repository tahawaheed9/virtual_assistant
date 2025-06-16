class AppTextStrings {
  AppTextStrings._();

  // App & Appbar Titles...
  static const String appTitle = 'Virtual Assistant';

  // App Drawer...
  static const String appDrawerHeading = 'M E N U';
  static const String appDrawerSettingTileText = 'Settings';

  // Tooltips & Hints...
  static const String menuButtonTooltip = 'Open drawer';
  static const String textFieldHint = 'Type your prompt...';

  // SnackBar Messages...
  static const String onListening = 'Listening...';
  static const String onEmptyField =
      'Please type the prompt or use the speech.';
  static const String onSpeechAvailable = 'Speech is now available!';
  static const String onSpeechError = 'Could not load Speech.';
  static const String onUnableToLaunchURL = 'Unable to launch the url';
  static const String onNullResponse = 'Could not fetch the response.';

  // Loading Screen Message...
  static const String onGeneratingResponse = 'Generating Response...';

  /* ------------ Home Page Text ------------ */

  // Response Bubble Greeting Text...
  static const String homeViewGreetingText =
      'Greetings! what task can I do for you?';

  // Feature Text...
  static const String featureHeading = 'Here are a few features.';

  // Feature Box Suggestions Title...
  static const String firstFeatureTitle = 'Gemini';
  static const String secondFeatureTitle = 'Smart Voice Assistant';

  // Response Text Disclaimer...
  static const String disclaimer =
      '$firstFeatureTitle makes mistakes, so double-check it.';

  // Feature Description...
  static const String firstFeatureDescription =
      'A smarter way to stay organized and informed with $firstFeatureTitle.';
  static const String secondFeatureDescription =
      'Talk to your assistant naturally and get intelligent, real-time responses '
      'powered by $firstFeatureTitle AI. Whether you need quick answers, task '
      'help, or just a friendly chat, our assistant is here to help.';

  /* ------------ Settings Page Text ------------ */
  static const String settingsAppBarTitle = 'Settings';
  static const String appearanceHeading = 'Appearance';
  static const String darkThemeHeading = 'Dark theme';
  static const String darkThemeSubtitle = 'Will never turn off automatically';
}
