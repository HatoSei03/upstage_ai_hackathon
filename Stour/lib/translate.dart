import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stour/model/upstage.dart';

void main() async {
  const input = '엄마도들어가셨다';

  final translation = await getTranslation(input);

  print('Translation: $translation');
}

Future<String> getTranslation(String input) async {
  const String url = 'https://api.upstage.ai/v1/solar/chat/completions';

  final Map<String, String> headers = {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };

  final message = [
    {"role": "user", "content": "아버지가방에들어가셨다"},
    {"role": "assistant", "content": "Father went into his room"},
    {"role": "user", "content": input}
  ];

  final Map<String, dynamic> body = {
    'model': 'solar-1-mini-translate-koen',
    'messages': message,
    'stream': true,
  };

  try {
    final client = http.Client();
    final request = http.Request('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    final streamedResponse = await client.send(request);

    print(streamedResponse.statusCode);

    if (streamedResponse.statusCode == 200) {
      String response = '';
      await for (String chunk
          in streamedResponse.stream.transform(utf8.decoder)) {
        final parts = chunk.split('\n');
        for (var part in parts) {
          print(response);
          if (part.startsWith('data: ')) {
            final data = part.substring(6);
            if (data != '[DONE]') {
              try {
                final jsonData = jsonDecode(data);
                final content = jsonData['choices'][0]['delta']['content'];
                if (content != null) {
                  response += content;
                }
              } catch (e) {
                print('Error parsing JSON: $e');
              }
            }
          }
        }
      }
      return response;
    } else {
      return 'Error: ${streamedResponse.statusCode}';
    }
  } catch (e) {
    return 'Error: $e';
  }
}
