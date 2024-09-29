import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:juju/screens/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/Lottie/splash_screen.json',
            height: 200,
            repeat: true,
          ),
          const SizedBox(height: 20),

          const Text(
            'Welcome to Juju',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      nextScreen: const MainScreen(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color(0xFF18afba),
      splashIconSize: 400,
      duration: 2000,
    );
  }
}
