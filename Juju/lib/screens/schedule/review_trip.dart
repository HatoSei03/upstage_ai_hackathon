import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:juju/util/const.dart';
import 'package:juju/model/schedule.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:juju/util/location.dart';
import 'package:intl/intl.dart';
import 'package:juju/screens/schedule/schedule.dart';
import 'package:juju/screens/schedule/budget.dart';
import 'package:juju/screens/schedule/onboarding_timeline.dart';

class ReviewTripScreen extends StatefulWidget {
  Schedule schedule;
  ReviewTripScreen(this.schedule, {super.key});

  @override
  _ReviewTripScreenState createState() => _ReviewTripScreenState();
}

class _ReviewTripScreenState extends State<ReviewTripScreen> {
  TextEditingController tripNameController = TextEditingController();

  @override
  void initState() {
    tripNameController.text = widget.schedule.name;
    super.initState();
  }

  @override
  void dispose() {
    tripNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                'Review your choices',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trip name',
                style: GoogleFonts.rubik(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: tripNameController,
                decoration: InputDecoration(
                  hintText: 'Enter trip name',
                  hintStyle: GoogleFonts.rubik(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xffFFF9F3).withOpacity(0.6),
                  ),
                  filled: true,
                  fillColor: const Color(0xff18AFBA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                ),
                keyboardType: TextInputType.text,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffFFF9F3),
                ),
                onChanged: (value) {
                  widget.schedule.name = value;
                },
              ),
              const SizedBox(height: 36.0),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    _buildReviewItem(
                      icon: BoxIcons.bx_group,
                      label: 'Number of travelers',
                      value:
                          '${widget.schedule.travelerNum} ${widget.schedule.travelerNum == 1 ? 'person' : 'people'}',
                      onEdit: () {
                        Get.to(() => BudgetScreen(widget.schedule))?.then((_) {
                          setState(() {});
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),
                    _buildReviewItem(
                      icon: BoxIcons.bx_time_five,
                      label: 'Time',
                      value:
                          '${widget.schedule.time[0].format(context)} - ${widget.schedule.time[1].format(context)}',
                      onEdit: () {
                        Get.to(() => ScheduleScreen(widget.schedule))
                            ?.then((_) {
                          setState(() {});
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),
                    _buildReviewItem(
                      icon: IconsaxPlusLinear.calendar,
                      label: 'Travel dates',
                      value:
                          '${DateFormat('dd/MM/yyyy').format(widget.schedule.dates[0])} - ${DateFormat('dd/MM/yyyy').format(widget.schedule.dates[1])}',
                      onEdit: () {
                        Get.to(() => ScheduleScreen(widget.schedule))
                            ?.then((_) {
                          setState(() {});
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),
                    _buildReviewItem(
                      icon: BoxIcons.bx_wallet,
                      label: 'Budget',
                      value:
                          '\$${widget.schedule.budget[0]} - \$${widget.schedule.budget[1]}',
                      onEdit: () {
                        Get.to(() => BudgetScreen(widget.schedule))?.then((_) {
                          setState(() {});
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),
                    _buildReviewItem(
                      icon: BoxIcons.bxs_user_detail,
                      label: 'Budget Type',
                      value: widget.schedule.budgetType,
                      onEdit: () {
                        Get.to(() => BudgetScreen(widget.schedule))?.then((_) {
                          setState(() {});
                        });
                      },
                    ),
                  ],
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
                      Get.to(() => ScheduleLoadingScreen(widget.schedule));
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
                      'Generate Ideal Plan',
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
      ),
    );
  }

  Widget _buildReviewItem({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Constants.templateBlue,
            size: 22,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Constants.templateBlue,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              BoxIcons.bx_edit,
              color: Constants.templateBlue,
              size: 26,
            ),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
