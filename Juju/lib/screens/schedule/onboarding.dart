import 'package:flutter/material.dart';
import 'package:juju/model/schedule.dart';
import 'package:juju/screens/community/onboarding/onboarding_data.dart';
import 'package:juju/util/const.dart';
import 'package:get/get.dart';
import 'package:juju/screens/schedule/schedule.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingSchedule extends StatefulWidget {
  const OnboardingSchedule({super.key});

  @override
  State<OnboardingSchedule> createState() => _OnboardingScheduleState();
}

class _OnboardingScheduleState extends State<OnboardingSchedule> {
  final pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Images
                      Image.asset("assets/img/onboarding_schedule.jpg"),

                      const SizedBox(height: 15),
                      //Titles
                      Text(
                        "Effortless Trip Planning with Itinerary Generator",
                        style: GoogleFonts.rubik(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      //Description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          "Plan your perfect trip with ease! Tell us your travel details and our Itinerary Generator will craft a personalized schedule tailored to your needs. ",
                          style: GoogleFonts.rubik(
                              color: Colors.grey, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36.0, bottom: 36.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(
                      () => ScheduleScreen(
                        Schedule(
                          "Jeju Trip",
                          "Budget friendly",
                          0,
                          1,
                          [DateTime.now(), DateTime.now()],
                          [
                            const TimeOfDay(hour: 0, minute: 0),
                            const TimeOfDay(hour: 23, minute: 59)
                          ],
                          [],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: GoogleFonts.rubik(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: const Color(0xffEF7168),
                  ),
                  child: Text(
                    'Start Scheduling',
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
