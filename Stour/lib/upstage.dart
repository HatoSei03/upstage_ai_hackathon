import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upstage AI Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _promptController = TextEditingController();
  String _response = '';
  bool _isLoading = false;

  Future<void> _sendPrompt() async {
    setState(() {
      _isLoading = true;
      _response = '';
    });

    const String apiKey = 'up_34nJBBm1jGJWcYhjX2H5X3tLKUfRx';
    const String url = 'https://api.upstage.ai/v1/solar/chat/completions';

    final Map<String, String> headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      'model': 'solar-1-mini-chat',
      'messages': [
        {
          'role': 'system',
          'content': """
You are a knowledgeable and friendly AI consultant for tours to Jeju Island, South Korea.
The current datetime is: 15/8/2024
Your mission is to provide users with information on tours to Jeju Island based on customer needs such as the number of days, desired destinations, budget, and number of people. These information will be placed in JSON format as following

'''
{"days": number_of_days(int), "places": [list of string of places' name going to go], "people_num": number_of_people(int), "budget": users'budget(int)}
'''

Please perform the following tasks:
Build an itinerary: Create an engaging, lively, and appealing itinerary for a tour to Jeju Island based on the user's provided needs.
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
"""
        },
        {
          'role': 'user',
          'content': _promptController.text,
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
        streamedResponse.stream.transform(utf8.decoder).listen((String chunk) {
          final parts = chunk.split('\n');
          for (var part in parts) {
            if (part.startsWith('data: ')) {
              final data = part.substring(6);
              if (data != '[DONE]') {
                try {
                  final jsonData = jsonDecode(data);
                  final content = jsonData['choices'][0]['delta']['content'];
                  if (content != null) {
                    setState(() {
                      _response += content;
                    });
                  }
                } catch (e) {
                  print('Error parsing JSON: $e');
                }
              }
            }
          }
        }, onDone: () {
          setState(() {
            _isLoading = false;
          });
        });
      } else {
        setState(() {
          _response = 'Error: ${streamedResponse.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upstage AI Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _promptController,
              decoration: InputDecoration(
                hintText: 'Enter your prompt here',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendPrompt,
              child: Text(_isLoading ? 'Sending...' : 'Send'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_response),
              ),
            ),
          ],
        ),
      ),
    );
  }
}