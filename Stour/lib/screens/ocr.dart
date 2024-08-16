import 'package:flutter/material.dart';
import 'dart:io';
import 'package:stour/util/const.dart';
import 'package:stour/model/upstage.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key, required this.imagePath});
  final String imagePath;
  @override
  // ignore: library_private_types_in_public_api
  _OCRScreenState createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  String _response = '';
  String translated = '';
  String image = '';

  @override
  void initState() {
    super.initState();
    image = widget.imagePath;
    _performOCR();
  }

  Future<void> _performOCR() async {
    String response = await performOCR(image);
    // response = parseMainContent(response);
    setState(() {
      _response = response;
    });
  }

  Future<void> translate() async {
    translated = await getTranslation(_response);
    setState(() {
      _response = translated;
    });
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Tooltip(
                                message: 'Translate',
                                child: IconButton(
                                  onPressed: translate,
                                  icon: const Icon(Icons.translate, size: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: displayText(_response),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
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
        style: const TextStyle(fontSize: 14),
      ),
    ),
  );
}
