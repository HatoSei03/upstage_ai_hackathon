import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/screens/schedule/budget.dart';
import 'package:juju/util/const.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';
import 'package:juju/model/schedule.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen(this.schedule, {super.key});
  Schedule schedule; 

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _focusedDay = DateTime.now();

  bool _selectingStartDate = true;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return Scaffold(
      backgroundColor: Constants.background,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Constants.background,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Schedule',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w600,
                  fontSize: 32.0,
                ),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
          child: IconButton(
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Constants.backArrow,
              size: 26,
            ),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time',
                  style: GoogleFonts.rubik(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimePickerField(
                      label: 'Start time',
                      selectedTime: widget.schedule.time[0],
                      onTimePicked: (time) =>
                          setState(() => widget.schedule.time[0] = time),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        color: Color(0xff18AFBA),
                      ),
                    ),
                    _buildTimePickerField(
                      label: 'End time',
                      selectedTime: widget.schedule.time[1],
                      onTimePicked: (time) =>
                          setState(() => widget.schedule.time[1] = time),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildDateRangePickerSection(),
            const Spacer(),
            Padding(
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
                    Get.to(() => BudgetScreen(widget.schedule));
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
                    'Continue',
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

  Widget _buildTimePickerField({
    required String label,
    required TimeOfDay? selectedTime,
    required Function(TimeOfDay) onTimePicked,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.rubik(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
            );
            if (pickedTime != null) onTimePicked(pickedTime);
          },
          child: Container(
            width: 160,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xff18AFBA).withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                selectedTime != null ? selectedTime.format(context) : '__ A.M',
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRangePickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose your start date and end date',
          style: GoogleFonts.rubik(
            letterSpacing: -0.2,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 18),
        _buildCalendar(),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Start date',
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectingStartDate = true;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        IconsaxPlusLinear.calendar_edit,
                        color: Colors.teal.shade300,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: _selectingStartDate
                            ? BoxDecoration(
                                color: _selectingStartDate
                                    ? Colors.teal.shade200
                                    : Colors.teal.shade100,
                                borderRadius: BorderRadius.circular(8),
                              )
                            : null,
                        child: Text(
                          DateFormat.yMMMd().format(widget.schedule.dates[0]),
                          style: GoogleFonts.rubik(
                            fontSize: 14,
                            color: _selectingStartDate
                                ? Colors.white
                                : const Color(0xff0B799E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Icon(
                CupertinoIcons.arrow_right,
                color: Color(0xff18AFBA),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    'End date',
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectingStartDate = false;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        IconsaxPlusLinear.calendar_tick,
                        color: Colors.teal.shade300,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: !_selectingStartDate
                            ? BoxDecoration(
                                color: !_selectingStartDate
                                    ? Colors.teal.shade200
                                    : Colors.teal.shade100,
                                borderRadius: BorderRadius.circular(8),
                              )
                            : null,
                        child: Text(
                          DateFormat.yMMMd().format(widget.schedule.dates[1]),
                          style: GoogleFonts.rubik(
                            fontSize: 14,
                            color: !_selectingStartDate
                                ? Colors.white
                                : const Color(0xff0B799E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return Stack(
      children: [
        Positioned(
            child: Container(
          height: 365,
          width: 400,
          decoration: BoxDecoration(
            color: const Color(0xff18AFBA).withOpacity(0.5),
            borderRadius: BorderRadius.circular(24),
          ),
        )),
        TableCalendar(
          firstDay: DateTime(2000),
          lastDay: DateTime(2100),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          selectedDayPredicate: (day) {
            return isSameDay(day, widget.schedule.dates[0]) ||
                isSameDay(day, widget.schedule.dates[1]);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _focusedDay = focusedDay;

              if (_selectingStartDate) {
                widget.schedule.dates[0] = selectedDay;
                if (widget.schedule.dates[1].isBefore(widget.schedule.dates[0])) {
                  widget.schedule.dates[1] = widget.schedule.dates[0];
                }
              } else {
                widget.schedule.dates[1] = selectedDay.isAfter(widget.schedule.dates[0])
                    ? selectedDay
                    : widget.schedule.dates[0];
              }
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          headerStyle: HeaderStyle(
            headerPadding: const EdgeInsets.all(12),
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronIcon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff292D32),
              size: 20,
            ),
            rightChevronIcon: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xff292D32),
              size: 20,
            ),
            titleTextStyle: GoogleFonts.rubik(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: const Color(0xff3A4646),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xff3A4646).withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
          ),
          calendarStyle: CalendarStyle(
            tablePadding: const EdgeInsets.all(12),
            todayDecoration: BoxDecoration(
              color: Colors.teal.shade300,
              shape: BoxShape.circle,
            ),
            selectedDecoration: const BoxDecoration(
              color: Color(0xfffff9f3),
              shape: BoxShape.circle,
            ),
            defaultTextStyle: GoogleFonts.rubik(
              color: const Color(0xff3A4646),
              fontSize: 20,
            ),
            rangeHighlightColor: const Color(0xff3A4646),
          ),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return Center(
                child: Text(
                  '${day.day}',
                  style: GoogleFonts.rubik(
                    color: const Color(0xff3A4646),
                    fontSize: 16,
                  ),
                ),
              );
            },
            todayBuilder: (context, day, focusedDay) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade200,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xfffff9f3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: GoogleFonts.rubik(
                      color: const Color(0xff3A4646),
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
