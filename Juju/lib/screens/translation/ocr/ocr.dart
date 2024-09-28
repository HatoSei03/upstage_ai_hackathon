import 'package:flutter/material.dart';
import 'dart:io';
import 'package:juju/util/const.dart';
import 'package:juju/model/upstage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/screens/translation/ocr/ocr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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
    print(response);
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'PhotoTranslator',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w600,
                  fontSize: 28.0,
                ),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
          child: IconButton(
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Constants.backArrow,
              size: 26,
            ),
            onPressed: () => Get.back(),
          ),
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
                ElevatedButton.icon(
                  onPressed: translate,
                  icon: Icon(
                    Icons.translate,
                    color: Constants.lightText,
                  ),
                  label: Text(
                    'Translate to English',
                    style: GoogleFonts.rubik(
                      color: Constants.lightText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.header,
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
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
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
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
  );
}

Widget displayText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
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
            style: GoogleFonts.rubik(
              fontSize: 16,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ),
      ),
    ),
  );
}
