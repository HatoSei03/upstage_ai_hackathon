import 'package:flutter/material.dart';
import 'package:juju/model/schedule.dart';
import 'package:juju/screens/home.dart';
import 'package:juju/util/const.dart';
import 'package:juju/screens/community/widget/profile.dart';
import 'package:juju/screens/ocr/camera_screen.dart';
import 'package:juju/screens/schedule/onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:juju/screens/community/onboarding/onboarding.dart';
import 'package:juju/screens/shop/model/cart_model.dart';
import 'package:juju/screens/shop/pages/intro_screen.dart';
import 'package:provider/provider.dart';
import 'package:juju/screens/community/social_media.dart';

List<IconData> icons = [
  Icons.document_scanner_outlined,
  Icons.timeline_outlined,
  Icons.home_outlined,
  BoxIcons.bx_store_alt,
  Icons.person_outline,
];

List<Widget> pages = [
  const CameraAwesomeApp(),
  const OnboardingSchedule(),
  const Home(),
  ChangeNotifierProvider(
    create: (context) => CartModel(),
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    ),
  ),
  const SocialMediaScreen(),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  Color selected = const Color(0xff0B799E);
  Color unselected = const Color(0xff484C52);
  int _selectedIndex = 2;
  late PageController _pageController;

  late List<AnimationController> _animationControllers;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _animationControllers = List.generate(
      icons.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0.0,
        upperBound: 1.0,
      ),
    );

    _animationControllers[_selectedIndex].value = 1.0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _animationControllers[_selectedIndex].reverse();
      _selectedIndex = index;
      _animationControllers[_selectedIndex].forward();
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildBarItem(int index, String label) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 2,
              width: isSelected ? 56 : 0,
              decoration: BoxDecoration(
                color: isSelected ? selected : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            // Animated Icon and Label
            Column(
              children: [
                Icon(
                  icons[index],
                  size: 24,
                  color: isSelected ? selected : unselected,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: GoogleFonts.rubik(
                    color: isSelected ? selected : unselected,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              _buildBarItem(0, 'OCR'),
              _buildBarItem(1, 'Timeline'),
              _buildBarItem(2, 'Home'),
              _buildBarItem(3, 'Shop'),
              _buildBarItem(4, 'Community'),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}
