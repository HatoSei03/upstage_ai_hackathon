import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:stour/screens/home.dart';
import 'package:stour/screens/timeline.dart';
import 'package:stour/util/const.dart';
import 'package:stour/screens/profile.dart';
import 'package:stour/screens/chatbot.dart';
import 'package:stour/screens/camera_screen.dart';

List icons = [
  Icons.document_scanner_outlined,
  Icons.chat_outlined,
  Icons.home_outlined,
  Icons.timeline_outlined,
  Icons.person_outline,
];

List<Widget> pages = [
  const CameraAwesomeApp(),
  const ChatbotSupportScreen(),
  const Home(),
  const Timeline(),
  const Profile(),
  // const ReviewScreen(),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Constants.lightBG,
      bottomNavigationBar: HomeBottomBar(
        onTap: navigationTapped,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              // onPageChanged: onPageChanged,
              children: List.generate(5, (index) => pages[index]),
            ),
          ),
        ],
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 2);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class HomeBottomBar extends StatelessWidget {
  final Function(int) onTap;
  const HomeBottomBar({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Constants.palette2,
      buttonBackgroundColor: Constants.palette3,
      index: 2,
      items: [
        Icon(icons[0], size: 30, color: Constants.paletteDark),
        Icon(icons[1], size: 30, color: Constants.paletteDark),
        Icon(icons[2], size: 30, color: Constants.paletteDark),
        Icon(icons[3], size: 30, color: Constants.paletteDark),
        Icon(icons[4], size: 30, color: Constants.paletteDark),
      ],
      onTap: onTap,
    );
  }
}
