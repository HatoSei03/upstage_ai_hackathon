import 'package:flutter/material.dart';
import 'package:juju/model/places.dart';
import 'package:juju/model/schedule.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/screens/chatbot.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:juju/util/const.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:juju/screens/main_screen.dart';
import 'package:juju/screens/schedule/view_saved_tour.dart';
import 'package:juju/screens/details/details.dart';
import 'package:juju/font/solar_l_l_m_icons.dart';

class TimelineScreen extends StatefulWidget {
  final Schedule schedule;
  final String response;

  const TimelineScreen(this.schedule, this.response, {super.key});

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen>
    with SingleTickerProviderStateMixin {
  int focusedDayIndex = 0;
  List<bool> isCardExpanded = [];

  @override
  void initState() {
    super.initState();
    isCardExpanded = List<bool>.filled(
        widget.schedule.places.isNotEmpty
            ? widget.schedule.places[0].length
            : 0,
        false);
  }

  @override
  void didUpdateWidget(covariant TimelineScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    isCardExpanded = List<bool>.filled(
        widget.schedule.places.isNotEmpty
            ? widget.schedule.places[focusedDayIndex].length
            : 0,
        false);
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
                'Trip Details Plan',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w600,
                  fontSize: 26.0,
                ),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
          child: IconButton(
            icon: Icon(
              CupertinoIcons.xmark,
              color: Constants.backArrow,
              size: 26,
            ),
            onPressed: () async {
              final updatedSchedule = await Get.to(() => const MainScreen());
              if (updatedSchedule != null && updatedSchedule is Schedule) {
                setState(() {
                  widget.schedule.name = updatedSchedule.name;
                  widget.schedule.budgetType = updatedSchedule.budgetType;
                  widget.schedule.budget = updatedSchedule.budget;
                  widget.schedule.travelerNum = updatedSchedule.travelerNum;
                  widget.schedule.dates = updatedSchedule.dates;
                  widget.schedule.time = updatedSchedule.time;
                  widget.schedule.places = updatedSchedule.places;
                  widget.schedule.activities = updatedSchedule.activities;
                  widget.schedule.createdDate = updatedSchedule.createdDate;
                  isCardExpanded = List<bool>.filled(
                      widget.schedule.places.isNotEmpty
                          ? widget.schedule.places[focusedDayIndex].length
                          : 0,
                      false);
                });
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildOverallInfo(),
            _buildDaySelectionRow(),
            Expanded(child: _buildPlaceStepper()),
            _buildSaveScheduleButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallInfo() {
    int dayNum = widget.schedule.dates.length;
    double totalMoney = 0;
    for (int i = 0; i < dayNum; i++) {
      for (int j = 0; j < widget.schedule.places[i].length; j++) {
        totalMoney += widget.schedule.places[i][j].price;
      }
    }
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.schedule.name,
                    style: GoogleFonts.rubik(
                      color: const Color.fromARGB(255, 35, 52, 10),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Days: ${dayNum.toString()}',
                    style: GoogleFonts.rubik(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 35, 52, 10),
                    ),
                  ),
                  Text(
                    'Estimated Cost: ${totalMoney.toStringAsFixed(0)}\$',
                    style: GoogleFonts.rubik(
                      color: const Color.fromARGB(255, 35, 52, 10),
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final result =
                      await Get.to(() => ViewSavedTour(widget.schedule));
                  if (result != null && result is Schedule) {
                    setState(() {
                      widget.schedule.name = result.name;
                      widget.schedule.budgetType = result.budgetType;
                      widget.schedule.budget = result.budget;
                      widget.schedule.travelerNum = result.travelerNum;
                      widget.schedule.dates = result.dates;
                      widget.schedule.time = result.time;
                      widget.schedule.places = result.places;
                      widget.schedule.activities = result.activities;
                      widget.schedule.createdDate = result.createdDate;
                      isCardExpanded = List<bool>.filled(
                          widget.schedule.places.isNotEmpty
                              ? widget.schedule.places[focusedDayIndex].length
                              : 0,
                          false);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                label: Text(
                  "Edit schedule",
                  style: GoogleFonts.rubik(
                    color: const Color(0xFF23340A),
                    fontSize: 12,
                  ),
                ),
                icon: Icon(
                  BoxIcons.bx_calendar_edit,
                  color: const Color(0xff0B799E).withOpacity(0.6),
                  size: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaySelectionRow() {
    DateTime startDay = widget.schedule.dates.isNotEmpty
        ? widget.schedule.dates[0]
        : DateTime.now();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(widget.schedule.dates.length, (index) {
                  DateTime date = startDay.add(Duration(days: index));
                  return _buildDayButton(index, date);
                }),
              ),
            ),
          ),
          IconButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(8.0),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
              shadowColor: WidgetStateProperty.all<Color>(
                Colors.black.withOpacity(0.5),
              ),
              elevation: WidgetStateProperty.all<double>(4.0),
            ),
            onPressed: () {
              Get.to(() => ChatbotSupportScreen(context: widget.response));
            },
            icon: const Icon(
              SolarLLM.solarllm_symbol_color,
              color: Color(0xff8796ff),
              size: 38.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton(int index, DateTime date) {
    const Color selectedColor = Color(0xff18AFBA);
    bool isSelected = index == focusedDayIndex;
    String formattedDate = "${date.day.toString().padLeft(2, '0')} "
        "${_getMonthAbbreviation(date.month)} "
        "${date.year}";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                focusedDayIndex = index;
                isCardExpanded = List<bool>.filled(
                    widget.schedule.places[focusedDayIndex].length, false);
              });
            },
            child: Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Day ${index + 1}',
                    style: GoogleFonts.rubik(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: GoogleFonts.rubik(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
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
    );
  }

  String _getMonthAbbreviation(int month) {
    const List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  Widget _buildSaveScheduleButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36.0),
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
            widget.schedule.createdDate = DateTime.now();

            savedTour.add([widget.schedule, widget.response]);

            Get.snackbar(
              'Success',
              'I have successfully saved to tour to my profile.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.7),
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
            );

            Get.offAll(() => const MainScreen());
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
            'Save schedule',
            style: GoogleFonts.rubik(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceStepper() {
    if (widget.schedule.places.isEmpty ||
        focusedDayIndex >= widget.schedule.places.length) {
      return Center(
        child: Text(
          'No places available for this day.',
          style: GoogleFonts.rubik(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    List<Place> placesForDay = widget.schedule.places[focusedDayIndex];
    const orangeColor = Color(0xFFEF7168);
    return ListView.builder(
      itemCount: placesForDay.length,
      itemBuilder: (context, index) {
        if (index >= placesForDay.length) {
          return const SizedBox.shrink();
        }
        return TimelineTile(
          isFirst: index == 0,
          isLast: index == placesForDay.length - 1,
          indicatorStyle: IndicatorStyle(
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: 20,
            height: 20,
            color: orangeColor,
            indicator: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: orangeColor,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: GoogleFonts.rubik(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          afterLineStyle: const LineStyle(
            thickness: 2,
            color: orangeColor,
          ),
          beforeLineStyle: const LineStyle(
            thickness: 2,
            color: orangeColor,
          ),
          alignment: TimelineAlign.manual,
          lineXY: 0.08,
          endChild: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 24.0),
            child: _buildAnimatedCard(placesForDay[index], index),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedCard(Place place, int index) {
    if (index >= isCardExpanded.length) {
      return const SizedBox.shrink();
    }
    bool isExpanded = isCardExpanded[index];
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isCardExpanded[index] = !isExpanded;
          });
        },
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10.0),
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isExpanded ? 175 : 55,
                    width: double.infinity,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/localImg/placeholder.jpg',
                      image: place.img.isNotEmpty ? place.img[0] : '',
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/localImg/placeholder.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place.name,
                                style: GoogleFonts.rubik(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${TimeOfDay(hour: place.opentime.toInt(), minute: ((place.opentime % 1) * 60).toInt()).format(context)} - ${TimeOfDay(hour: place.closetime.toInt(), minute: ((place.closetime % 1) * 60).toInt()).format(context)}',
                                style: GoogleFonts.rubik(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (isExpanded)
                            IconButton(
                              onPressed: () {
                                Get.to(
                                  () => DetailsScreen(widget
                                      .schedule.places[focusedDayIndex][index]),
                                  transition: Transition.zoom,
                                );
                              },
                              icon: Icon(
                                BoxIcons.bx_info_circle,
                                color: const Color(0xff0B799E).withOpacity(0.6),
                                size: 20,
                              ),
                            )
                        ],
                      ),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: -8.0,
                        children: place.tag
                            .map(
                              (tag) => Chip(
                                label: Text(
                                  tag,
                                  style: GoogleFonts.rubik(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                                backgroundColor:
                                    const Color(0xff18AFBA).withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2.0,
                                  vertical: 0,
                                ),
                                side: BorderSide.none,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: isExpanded ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: isExpanded
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: const Color(0xff0B799E)
                                          .withOpacity(0.6),
                                      size: 14),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  SizedBox(
                                    width: 270,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        place.address,
                                        style: GoogleFonts.rubik(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff0B799E)
                                              .withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.schedule.activities[focusedDayIndex]
                                    [index],
                                style: GoogleFonts.rubik(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
