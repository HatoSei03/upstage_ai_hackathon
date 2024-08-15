import 'dart:convert';
import 'package:http/http.dart' as http;

String getSchedulePrompt(
    DateTime startDate, DateTime endDate, int peopleNum, double budget) {
  return """
    You are a knowledgeable and friendly AI consultant for tours to Ho Chi Minh City, Vietnam.
    The current datetime is: 16/8/2024
    Your mission is to provide users with information on tours to Ho Chi Minh City based on customer needs such as the number of days, desired destinations, budget, and number of people. These information will be placed in JSON format as following
  
    '''
    {"days": number_of_days(int), "places": [list of string of places' name to be included], "people_num": number_of_people(int), "budget": users'budget(int)}
    '''
  
    Please perform the following tasks:
    Build an itinerary: Create an engaging, lively, and appealing itinerary for a tour to Ho Chi Minh City based on the user's provided needs.
    Summarize information: Summarize the information for each day of the itinerary and provide a summary of the total cost (breakdown the cost into categories such as accommodation, food, etc.). Make sure that the total cost, sum of the element costs, and sum of the breakdown costs are equal and do not exceed the budget
  
    Output format: Output the information in JSON format.
  
    Example JSON format
    [
      [
        {
          "morning": {
            "places": "place to go for day 1 morning",
            "activities": "activities to do here",
            "cost": cost(int)
          },
          "afternoon": {
            "places": "place to go for day 1 afternoon",
            "activities": "activities to do here",
            "cost": cost(int)
          },
          "evening": {
            "places": "place to go for day 1 evening",
            "activities": "activities to do here",
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
  
  
    Please provide the most up-to-date information, no more than 3 months old from the current time
    Always respond in the language spoken in English

    {"days": ${startDate.day - endDate.day}, "places": [], "people_num": $peopleNum, "budget": $budget dollars}
      """;
}

String getChatbotContent() {
  return """
          You are a virtual tour guide of Jeju Island. 
          Your mission is to answer questions about Jeju island. 
          Do not answer and reply "I am not trained for this lol..." if the question is not related to Jeju Islands. 
          The answer should be short and concise with less than 100 words. 
          Do not give any recommendation if not asked to.
    """;
}

Future<String> getUpstageAIResponse(String content, String prompt) async {
  const String apiKey = 'up_34nJBBm1jGJWcYhjX2H5X3tLKUfRx';
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
