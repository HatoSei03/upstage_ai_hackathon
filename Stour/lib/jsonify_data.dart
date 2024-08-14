import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String jsonData = '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: _writeJsonData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Textbox(jsonData),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: jsonData));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('JSON data copied to clipboard')),
                        );
                      },
                      child: const Text('Save to clipboard'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _writeJsonData() async {
    String input = '''
Day 1:
Morning:
Vietnam National University, Ho Chi Minh City - Tour the campus and visit the science and technology museum. (free admission) 
Travel by bus to Ho Chi Minh City Museum of Fine Arts (3 people: 9,000 VND). 

Noon:
Ho Chi Minh City Museum of Fine Arts - Explore the art collection. (30,000 VND x 3 = 90,000 VND)
Have lunch at a local street food vendor (approx. 20,000 VND x 3 = 60,000 VND).

Afternoon:
Tran Hung Dao Temple - Light incense and pray for good fortune. (free admission)

Evening:
Independence Palace - Freely explore the bustling areas around.
Have dinner at a local street food vendor (approx. 20,000 VND x 3 = 60,000 VND).

Day 2:
Morning:
Ong Pagoda - Appreciate the beautiful architecture and serene environment of the pagoda. (free admission)

Noon:
Have lunch at a local street food vendor (approx. 20,000 VND x 3 = 60,000 VND).

Afternoon:
Bang Lang Stork Garden - Admire the beautiful storks. (20,000 VND x 3 = 60,000 VND)

Evening:
Freely explore the local cultural activities.

Day 3:
Morning:
Truc Lam Zen Monastery in the South - Experience the tranquil atmosphere of the pagoda. (20,000 VND x 3 = 60,000 VND)
Can Tho Museum - Learn about the local culture and history. (15,000 VND x 3 = 45,000 VND)

Noon:
Have lunch at a local street food vendor (approx. 20,000 VND x 3 = 60,000 VND).

Afternoon:
Freely explore the local markets and streets.
''';

    List<Map<String, dynamic>> data = [];

    List<String> day = input.split('Day');
    String currTime = '';
    String currPlace = '';
    String currPrice = '';
    String currDescription = '';
    for (var time in day) {
      for (var item in time.split('\n')) {
        if (item == "Morning:" ||
            item == "Noon:" ||
            item == "Afternoon:" ||
            item == "Evening:") {
          currTime = item.replaceFirst(':', '');
          continue;
        } else if (item.contains('-')) {
          currPlace = item.split(' - ')[0].trim();
          item.replaceAll(currPlace, '');
          currDescription = item;
          if (currDescription.contains('(')) {
            currPrice = currDescription.split('(')[1].split(')')[0];
            currDescription = currDescription.split('(')[0];
          } else {
            currPrice = 'Free admission';
          }
        } else {
          continue;
        }
        data.add({
          'time': currTime,
          'place': currPlace,
          'price': currPrice,
          'description': currDescription,
        });
      }
    }

    jsonData = jsonEncode(data);
  }
}

class Textbox extends StatelessWidget {
  final String text;

  const Textbox(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
