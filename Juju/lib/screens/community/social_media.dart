import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/screens/community/shorts/home.dart';
import 'package:juju/screens/community/feeds/home.dart';
import 'package:juju/util/const.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  int focusedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Constants.background,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 12, 6, 0),
                child: Row(
                  children: [
                    Expanded(child: _buildHeaderButton(0, 'Shorts')),
                    Expanded(child: _buildHeaderButton(1, 'Feeds')),
                  ],
                ),
              ),
              Expanded(
                child: focusedButtonIndex == 0 ? Reel() : FeedScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderButton(int index, String title) {
    const Color selectedColor = Color(0xff0B799E);
    bool isSelected = index == focusedButtonIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          focusedButtonIndex = index;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            alignment: Alignment.center,
            child: Text(
              title,
              style: GoogleFonts.rubik(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: isSelected ? selectedColor : Color(0xff111111),
              ),
            ),
          ),
          SizedBox(height: 6),
          Container(
            height: 2,
            width: double.infinity,
            color: isSelected ? selectedColor : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
