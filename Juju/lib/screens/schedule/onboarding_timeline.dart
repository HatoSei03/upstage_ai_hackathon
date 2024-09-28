import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/model/schedule.dart';
import 'package:juju/screens/schedule/generate_timeline.dart';
import 'package:juju/model/upstage.dart';
import 'package:juju/model/places.dart';

class ScheduleLoadingScreen extends StatefulWidget {
  Schedule schedule;

  ScheduleLoadingScreen(
    this.schedule, {
    super.key,
  });

  @override
  _ScheduleLoadingScreenState createState() => _ScheduleLoadingScreenState();
}

class _ScheduleLoadingScreenState extends State<ScheduleLoadingScreen> {
  List<String> prompt = [];
  String response = '';
  bool contentCopied = false;

  @override
  void initState() {
    super.initState();
    _generateSchedule();
  }

  Future<void> _generateSchedule() async {
    try {
      prompt = getSchedulePrompt(
          widget.schedule.dates[0],
          widget.schedule.dates[1],
          widget.schedule.travelerNum,
          widget.schedule.budget.toDouble());
      response = await getUpstageAIResponse(prompt[0], prompt[1]);
      print(response);

      List<String> placeNames = response.split('"places"');
      List<String> activities = response.split('"activities"');
      List<List<String>> placeActivities = [];

      activities = activities.map((e) {
        return e.split('"')[1];
      }).toList();
      activities.removeAt(0);

      placeNames = placeNames.map((e) {
        return e.split('"')[1];
      }).toList();
      placeNames.removeAt(0);
      List<List<Place>> placeList = [];

      for (var i = 0; i < placeNames.length; i++) {
        List<Place> tmp = [];
        List<String> tmpActivities = [];
        for (var j = 0; j < 3 && i < placeNames.length; j++, i++) {
          for (var place in places) {
            if (place.name == placeNames[i]) {
              tmp.add(place);
              break;
            }
          }
          tmpActivities.add(activities[i]);
          placeActivities.add(tmpActivities);
        }
        placeList.add(tmp);
      }
      widget.schedule.places = placeList;
      widget.schedule.activities = placeActivities;

      Get.offAll(() => TimelineScreen(widget.schedule, response));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate schedule. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xffEF7168)),
                    strokeWidth: 6.0,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Generating Your Schedule...',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please wait while we prepare your itinerary.',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
