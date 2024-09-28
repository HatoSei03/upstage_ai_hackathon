import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:juju/util/const.dart";
import "package:juju/util/location.dart";
import 'package:icons_plus/icons_plus.dart';
import 'package:get/get.dart';
import 'package:juju/screens/community/widget/profile.dart ';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: 0,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(
                    () => const Profile(),
                    transition: Transition.rightToLeftWithFade,
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(48, 48),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFFFFFFFF),
                  elevation: 1,
                ),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        blurRadius: 4,
                        offset: const Offset(0, 5),
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/splash_screen.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  BoxIcons.bx_current_location,
                  color: Constants.demoOrange,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  currentLocationDetail.isNotEmpty
                      ? '${currentLocationDetail[1]}, ${currentLocationDetail[2]}'
                      : "Error while loading location",
                  style: GoogleFonts.montserrat(
                    color: const Color(0xff6A778B),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
