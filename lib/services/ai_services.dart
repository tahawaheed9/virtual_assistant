import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:voice_assistant/utils/constants/api/app_api.dart';

class AIServices {
  Future<String> checkAIModel(String prompt) async {
    try {
      // final response = await http.post(
      //   Uri.parse(AppApi.chatCompletionUrl),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer ${AppApi.openAIApiKey}',
      //   },
      //   body: jsonEncode({
      //     'model': 'gpt-4.1',
      //     'messages': [
      //       {
      //         'role': 'user',
      //         'context':
      //             'Does this prompt want to generate an AI picture, image or an art $prompt? Answer with "yes" or "no".',
      //       },
      //     ],
      //   }),
      // );
      // debugPrint(response.body);
      // if (response.statusCode == 200) {}
      return 'AI';
    } catch (error) {
      debugPrint('Error in checkAIModel: $error');
      return 'Error: $error';
    }
  }

  Future<String> textModelAPI(String prompt) async {
    return 'Chat GPT';
  }

  Future<String> imageModelAPI(String prompt) async {
    return 'Dall E';
  }
}
