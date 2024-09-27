import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart'; // Added for GoogleFonts
import 'package:juju/screens/community/shorts/home.dart'; // Added for PageView

void main() {
  runApp(const SocialMediaScreen());
}

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  int focusedButtonIndex = 0; // 0 for 'Shorts', 1 for 'Feeds'

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF7F1EC),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeaderButton(0, 'Shorts'),
                    _buildHeaderButton(1, 'Feeds'),
                  ],
                ),
              ),

              Expanded(
                child: Reel(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderButton(int index, String title) {
    const Color selectedColor = Color(0xff18AFBA);
    bool isSelected = index == focusedButtonIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            focusedButtonIndex = index;
          });
        },
        child: Column(
          children: [
            Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.rubik(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '', // No date formatting needed for header buttons
                    style: GoogleFonts.rubik(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 2,
              width: 100,
              color: isSelected ? selectedColor : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
