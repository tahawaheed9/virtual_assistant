import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:virtual_assistant/utils/constants/api/app_api.dart';

class AIServices {
  final List<Object> contents = [];
  Future<String> getAIModelResponse(String prompt) async {
    late final String textResponse;
    // Adding the user's messages to the list to keep record...
    contents.add([
      {
        'parts': [
          {'text': prompt},
        ],
        'role': 'user',
      },
    ]);
    try {
      final response = await http.post(
        Uri.parse(AppAPI.geminiURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'contents': contents}),
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        textResponse =
            jsonDecode(
              response.body,
            )['candidates'][0]['content']['parts'][0]['text'];
      }
      // Adding the model's messages to the list to keep record...
      contents.add([
        {
          'parts': [
            {'text': textResponse},
          ],
          'role': 'model',
        },
      ]);
      return textResponse.trim();
    } catch (error) {
      debugPrint('Error in getAIModelResponse: $error');
      return 'Error: $error';
    }
  }
}
