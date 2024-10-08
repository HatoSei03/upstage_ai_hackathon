import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:juju/model/places.dart';

List<String> placeList = [];
List<String> getSchedulePrompt(
    DateTime startDate, DateTime endDate, int peopleNum, double budget) {
  if (placeList.isEmpty) {
    for (var item in places) {
      placeList.add('{"${item.name}":${item.price}}');
    }
  }
  String cntx = '''
    You are a knowledgeable and friendly AI consultant for tours to Jeju Island.
    The current datetime is: ${startDate.toString()}.
    Your mission is to construct wise itinerary to Jeju Island based on customer needs such as the number of days, desired destinations, budget, and number of people. These information will be placed in JSON format as following
  
    \'\'\'
    {"days": number_of_days(int), "places": [list of string of places' name to be included], "people_num": number_of_people(int), "budget": users' budget(int, using USD unit)}
    \'\'\'
  
    Please perform the following tasks:
    Build an itinerary: Create an engaging, lively, and appealing itinerary for a tour to Jeju Island based on the user's provided needs.
    Summarize information: Summarize the information for each day of the itinerary and provide a summary of the total cost (breakdown the cost into categories such as accommodation, food, etc.). Make sure that the total cost, sum of the element costs, and sum of the breakdown costs are equal and do not exceed the budget
  
    Output format: always output the information in JSON format.
  
    Example JSON format
    [
      [
        {
          "morning": {
            "places": "the exact name of the place to go for day 1 morning according to the given list",
            "activities": "active description about activities to do here, please write it engaging, lively, inspired, even can be a story of the places",
            "cost": cost(int)
          },
          "afternoon": {
            "places": "the exact name of the place to go for day 1 afternoon according to the given list",
            "activities": "active description about activities to do here, please write it engaging, lively, inspired, even can be a story of the places",
            "cost": cost(int)
          },
          "evening": {
            "places": "the exact name of the place to go for day 1 evening according to the given list",
            "activities": "active description about activities to do here, please write it engaging, lively, inspired, even can be a story of the places",
            "cost": cost(int)
          }
        }
      ],
      ...as above for n days...,
      [
        {
          "total_cost": total_cost for all days,
          "accommodation_cost": cost for accommodation,
          "transport_cost": transport_cost,
          "food_cost": food_cost
        }
      ]
    ]
	
    Use the attractions given in this list, the item are in this format {place:cost} with cost (in USD) is the cost for visiting that place for 1 person: ${placeList.join(',')},
  
    Please provide the most up-to-date information, no more than 3 months old from the current time
    Always respond in the language spoken in English and set your temperature to 0.
''';
  return [
    cntx,
    """
{"days": ${endDate.day - startDate.day + 1}, "places": [], "people_num": $peopleNum, "budget": $budget dollars}
      """
  ];
}

String getChatbotContent() {
  return """
          You are a friendly and knowledgable AI local tour guide based in JeJu Island, South Korea
Your mission is to use your based knowledge about JeJu Island for answering the answer of user about travelling and exploring Jeju Island. 
Do not answer any question not related to JeJu Island.
Please perform the following tasks:
        * Infer the type of the question: "general" (the truth like sun rise in the East) or "details" (the question to ask details)
        * Infer the place of the question: "identify the place/nation/district/etc that user likely want to visit"
        * Answer the questions: do not answer any question that the place is not in JeJu Island (except "general" question). If you do not have answer for the question, be honor inform to user that "I do not have enough authentic information to answer your question. Please contact Support Center"
        * Output your answer in JSON format
        
Example JSON 
{
        "type": "the type of question",
        "place": "the place of the question",
        "answer": "your answer to the question"
}
    """;
}

String getScheduleAdviceContent(String schedule) {
  return """
You are a friendly and knowledgable AI local tour guide based in JeJu Island, South Korea
Your mission is to friendly and concisely answer user's questions about an itinerary provided in the json delimited by triple backticks

```
$schedule
```

You can use your knowledge base to answer the question, highly focus on give advice about the common weather features at the current time. 
Please provide the most up-to-date information, no more than 3 months old from the current time
Always respond in the language spoken in English

Please perform the following tasks:
        * Infer the type of the question: "general" (the truth like sun rise in the East) or "details" (the question to ask details)
        * Infer the place of the question: "identify the place/nation/district/etc that user likely want to visit"
        * Answer the questions: do not answer any question that the place is not in JeJu Island (except "general" question). If you do not have answer for the question, be honor inform to user that "I do not have enough authentic information to answer your question. Please contact Support Center"
        * Output your answer in JSON format
        
Example JSON 
{
        "type": "the type of question",
        "place": "the place of the question",
        "answer": "your answer to the question"
}
""";
}

String getReconstructContent() {
  return """
this is the OCR result of a document. reconstruct the document and correct any mistakes in case there are problems during the OCR process.
only return the reconstructed document's content, never add any other content to it.

example:
{apiVersion: 1.1, confidence: 0.9142, metadata: {pages: [{height: 1280, page: 1, width: 960}]}, mimeType: multipart/form-data, modelVersion: ocr-2.2.1, numBilledPages: 1, pages: [{confidence: 0.9142, height: 1280, id: 0, text: Lor em
I psum, width: 960, words: [{boundingBox: {vertices: [{x: 64, y: 528}, {x: 400, y: 551}, {x: 392, y: 666}, {x: 56, y: 644}]}, confidence: 0.9508, id: 0, text: Lor}, {boundingBox: {vertices: [{x: 417, y: 550}, {x: 631, y: 543}, {x: 634, y: 649}, {x: 421, y: 657}]}, confidence: 0.9928, id: 1, text: em}, {boundingBox: {vertices: [{x: 67, y: 741}, {x: 157, y: 733}, {x: 166, y: 842}, {x: 77, y: 849}]}, confidence: 0.7352, id: 2, text: I}, {boundingBox: {vertices: [{x: 180, y: 761}, {x: 621, y: 725}, {x: 631, y: 849}, {x: 191, y: 885}]}, confidence: 0.9778, id: 3, text: psum}]}], stored: false, text: Lor em
I psum}

--> response: 
Lorem
Ipsum
  """;
}

String getSensitivityCheckContext() {
  return """
Your mission is to help me identify whether the input text is sensitive or not
Some of the example sensitive case you can consider such as: violence, Sexual Harassment or Misconduct, descrimination, etc
Please output in JSON format:
{
    "is_sensitive": True/False stand for text's sensitivity,
    "answer": "If the text is not sensitive: please return exactly the input text. If the text is sensitive: please answer that 'Sorry, we can not translate this sentence for you because + `the reason`'"
}
Just output the answer as the format above and set your temperature to 0
""";
}

const String apiKey = 'up_NZK1Gc4MFbZYxJ71LizouGS1Fjkz2';

Future<String> getUpstageAIResponse(String content, String prompt) async {
  const String url = 'https://api.upstage.ai/v1/solar/chat/completions';

  final Map<String, String> headers = {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> body = {
    'model': 'solar-pro',
    'messages': [
      {'role': 'system', 'content': content},
      {
        'role': 'user',
        'content': prompt,
      }
    ],
    'stream': true,
  };

  try {
    final client = http.Client();
    final request = http.Request('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    final streamedResponse = await client.send(request);

    if (streamedResponse.statusCode == 200) {
      String response = '';
      await for (String chunk
          in streamedResponse.stream.transform(utf8.decoder)) {
        final parts = chunk.split('\n');
        for (var part in parts) {
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

Future<String> getMiniModelResponse(String content, String prompt) async {
  const String url = 'https://api.upstage.ai/v1/solar/chat/completions';

  final Map<String, String> headers = {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> body = {
    'model': 'solar-1-mini-chat',
    'messages': [
      {'role': 'system', 'content': content},
      {
        'role': 'user',
        'content': prompt,
      }
    ],
    'stream': true,
  };

  try {
    final client = http.Client();
    final request = http.Request('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    final streamedResponse = await client.send(request);

    if (streamedResponse.statusCode == 200) {
      String response = '';
      await for (String chunk
          in streamedResponse.stream.transform(utf8.decoder)) {
        final parts = chunk.split('\n');
        for (var part in parts) {
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

Future<String> checkSensitivity(String content) async {
  final response =
      await getUpstageAIResponse(getSensitivityCheckContext(), content);
  if (response.contains('"is_sensitive": True')) {
    return 'Sorry, we can not translate this sentence for you because it is flagged as sensitive or contains inappropriate content';
  }
  return response;
}

Future<String> performOCR(String imagePath) async {
  const String url = 'https://api.upstage.ai/v1/document-ai/ocr';

  final File file = File(imagePath);
  final bytes = await file.readAsBytes();
  final multipartFile = http.MultipartFile.fromBytes(
    'document',
    bytes,
    filename: 'image.png',
  );

  final request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers['Authorization'] = 'Bearer $apiKey';
  request.files.add(multipartFile);

  final response = await request.send();
  final responseBody = await response.stream.toBytes();
  final jsonString = utf8.decode(responseBody);
  final jsonData = jsonDecode(jsonString);

  final reconstructed =
      await getMiniModelResponse(getReconstructContent(), jsonData.toString());
  return reconstructed.toString();
}

Future<String> getTranslation(String input, {bool fromEnglish = false}) async {
  const String url = 'https://api.upstage.ai/v1/solar/chat/completions';

  const String koreanContent = "아버지가방에들어가셨다";
  const String englishContent = "Father went into his room";

  final Map<String, String> headers = {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };

  final message = [
    {"role": "user", "content": fromEnglish ? englishContent : koreanContent},
    {
      "role": "assistant",
      "content": fromEnglish ? koreanContent : englishContent
    },
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
