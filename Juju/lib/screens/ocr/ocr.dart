import 'package:flutter/material.dart';
import 'dart:io';
import 'package:juju/util/const.dart';
import 'package:juju/model/upstage.dart';
import 'package:get/get.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key, required this.imagePath});
  final String imagePath;
  @override
  _OCRScreenState createState() => _OCRScreenState();
}

bool _isLoading = false;

class _OCRScreenState extends State<OCRScreen> {
  String _currContent = '';
  String _response = '';
  String translated = '';
  String image = '';
  bool isEn = true;

  @override
  void initState() {
    super.initState();
    image = widget.imagePath;
    _performOCR();
  }

  Future<void> _performOCR() async {
    setState(() {
      _isLoading = true;
    });
    String response = await performOCR(image);
    setState(() {
      _response = response;
      _currContent = response;
      _isLoading = false;
    });
  }

  Future<void> translate() async {
    setState(() {
      _isLoading = true;
    });
    translated =
        translated == '' ? await getTranslation(_response) : translated;
    setState(() {
      if (_currContent == _response) {
        _currContent = translated;
      } else {
        _currContent = _response;
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PhotoTranslator',
          style: TextStyle(
            color: Constants.lightText,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Constants.header,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Constants.lightText,
          ),
          onPressed: () {
            Get.back();
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
                ElevatedButton(
                  onPressed: translate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.header,
                    elevation: 1,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.translate,
                        color: Constants.lightText,
                      ),
                      Text(
                        'Translate to English',
                        style: TextStyle(color: Constants.lightText),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Expanded(
                    child: displayText(_currContent),
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
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(1)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.file(
            File(imagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    ),
  );
}

Widget displayText(String text) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _isLoading ? 'Gathering Information...' : text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    ),
  );
}
