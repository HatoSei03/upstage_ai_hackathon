import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:get/get.dart';
import 'package:juju/util/const.dart';
import 'ocr/camera_screen.dart';
import 'package:juju/model/upstage.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TranslationHomePage extends StatefulWidget {
  const TranslationHomePage({super.key});

  @override
  _TranslationHomePageState createState() => _TranslationHomePageState();
}

class _TranslationHomePageState extends State<TranslationHomePage> {
  final TextEditingController _textController = TextEditingController();
  String _fromLanguage = 'English';
  String _toLanguage = 'Korean';
  bool _isLoading = false;
  String? _translatedText;
  String? _originalText;
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                // margin: const EdgeInsets.all(16.0),
                // padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInputZone(),
                    ),
                    const SizedBox(height: 16.0),
                    const Divider(),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: _buildResultZone(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildLanguageSelection(),
                  const SizedBox(height: 16.0),
                  _buildActionButtons(),
                ],
              ),
            ),
            const SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }

  Widget _buildInputZone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _isLoading
            ? const LinearProgressIndicator()
            : const SizedBox(height: 4.0),
        Expanded(
          child: TextField(
            controller: _textController,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: 'Enter text',
              hintStyle: GoogleFonts.rubik(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.3),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20.0,
              ),
            ),
            style: GoogleFonts.rubik(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultZone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _isLoading
            ? const LinearProgressIndicator()
            : const SizedBox(height: 0.0),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 20.0,
            ),
            child: Text(
              _translatedText ?? 'Translation will appear here',
              style: GoogleFonts.rubik(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: _selectFromLanguage,
          child: Text(
            _fromLanguage,
            style: GoogleFonts.rubik(
              fontSize: 16,
              color: Constants.templateBlue,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.swap_horiz,
            color: Constants.templateBlue,
          ),
          onPressed: _swapLanguages,
        ),
        TextButton(
          onPressed: _selectToLanguage,
          child: Text(
            _toLanguage,
            style: GoogleFonts.rubik(
              fontSize: 16,
              color: Constants.templateBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            Icons.mic,
            color: _isListening ? Colors.red : Constants.templateBlue,
          ),
          tooltip: 'Voice Input',
          onPressed: _onMicPressed,
        ),
        ElevatedButton(
          onPressed: _onTranslateNowPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffEF7168),
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          child: Text(
            'Translate',
            style: GoogleFonts.rubik(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.camera_alt,
            color: Constants.templateBlue,
          ),
          tooltip: 'Camera Input',
          onPressed: _onCameraPressed,
        ),
      ],
    );
  }

  void _selectFromLanguage() {
  }

  void _selectToLanguage() {
  }

  void _swapLanguages() {
    setState(() {
      String temp = _fromLanguage;
      _fromLanguage = _toLanguage;
      _toLanguage = temp;
    });
  }

  void _onMicPressed() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if (val == 'done') {
            setState(() => _isListening = false);
            _onTranslateNowPressed();
          }
        },
        onError: (val) => setState(() => _isListening = false),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _textController.text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      _onTranslateNowPressed();
    }
  }

  Future<void> _onTranslateNowPressed() async {
    String inputText = _textController.text.trim();
    if (inputText.isEmpty) return;

    setState(() {
      _isLoading = true;
      _originalText = inputText;
    });

    String response = await checkSensitivity(inputText);
    if (response.contains('flagged as sensitive')) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('The text contains inappropriate content.')),
      );
      return;
    }

    String translation = await getTranslation(
      inputText,
      fromEnglish: _fromLanguage == 'English',
    );
    setState(() {
      _isLoading = false;
      _translatedText = translation;
    });
  }

  void _onCameraPressed() {
    Get.to(() => CameraAwesomeApp());
  }
}
