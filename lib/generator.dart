import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String?> generateIdea(name) async {
  var prompt = """generate a business idea and model based on the name: $name
                  and include the following: business identity, branding, uniqueness, regulations, distribution and record keeping. make the heading bold and
                  also generate a slogans for it
                  """;

  // Access your API key as an environment variable (see "Set up your API key" above)
  final apiKey = dotenv.env['API_KEY'];
  if (apiKey == null) {
    print('Incorrect API Key');
    exit(1);
  }

  final model =
      GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);
  final content = [Content.text(prompt)];
 try {
    final response = await model.generateContent(content);
    return response.text;
  } catch (e) {
    print('Failed to generate content: $e');
    return null;
  }
}
