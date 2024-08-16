import 'package:flutter/material.dart';
import 'dart:io';
import 'package:stour/util/const.dart';
import 'package:stour/model/upstage.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Image and Text Screen',
      home: OCRScreen(),
    );
  }
}

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  _OCRScreenState createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  String _response = '';

  String image =
      '/data/user/0/com.example.stour/cache/camerawesome/1723798191104308.jpg';

  @override
  void initState() {
    super.initState();
    _performOCR();
  }

  Future<void> _performOCR() async {
    String response = await performOCR(image);
    // response = parseMainContent(response);
    setState(() {
      _response = response;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _response));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Translator',
          style: TextStyle(
            color: Color.fromARGB(255, 35, 52, 10),
          ),
        ),
        backgroundColor: Constants.palette3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 35, 52, 10)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: displayImage(image),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: displayText(_response)),
                ElevatedButton.icon(
                  onPressed: _copyToClipboard,
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy to Clipboard'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 35, 52, 10),
                    backgroundColor: Constants.palette3,
                  ),
                ),
                SizedBox(height: 16), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget displayImage(String imagePath) {
  return SizedBox(
    width: 450,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Image.file(
        File(imagePath),
        fit: BoxFit.contain,
      ),
    ),
  );
}

Widget displayText(String text) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    ),
  );
}
