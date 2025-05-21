class AppTextStrings {
  AppTextStrings._();

  // App Title...
  static const String appTitle = 'Virtual Assistant';

  // Tooltips...
  static const String textFieldHint = 'Type your prompt...';
  static const String sendButtonText = 'Send';

  // Appbar Titles...
  static const String homeViewTitle = 'Virtual Assistant';

  static const String homeViewGreetingText =
      'Greetings! what task can I do for you?';

  static const String featureHeading = 'Here are a few features.';

  // Feature Box Suggestions Title...
  static const String firstFeatureTitle = 'Gemini';
  static const String secondFeatureTitle = 'Smart Voice Assistant';

  static const String disclaimer =
      '$firstFeatureTitle makes mistakes, so double-check it.';

  // Feature Description...
  static const String firstFeatureDescription =
      'A smarter way to stay organized and informed with $firstFeatureTitle.';
  static const String secondFeatureDescription =
      'Talk to your assistant naturally and get intelligent, real-time responses '
      'powered by $firstFeatureTitle AI. Whether you need quick answers, task '
      'help, or just a friendly chat, our assistant is here to help.';

  // Snackbar Messages...
  static const String onEmptyField = 'Please type the prompt or use the speech.';
  static const String onSpeechAvailable = 'Speech is now available!';
  static const String onError = 'Could not load Speech.';
}
