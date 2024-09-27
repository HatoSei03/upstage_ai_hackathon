import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/screens/schedule/review_trip.dart';
import 'package:juju/util/const.dart';
import 'package:juju/model/schedule.dart';

class BudgetScreen extends StatefulWidget {
  Schedule schedule;
  BudgetScreen(this.schedule, {super.key});

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen>
    with SingleTickerProviderStateMixin {
  bool travelingAlone = false;
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController travelersController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    minPriceController.text = widget.schedule.budget[0].toString();
    maxPriceController.text = widget.schedule.budget[1].toString();
    travelersController.text = widget.schedule.travelerNum.toString();
    travelingAlone = widget.schedule.travelerNum == 1;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (!travelingAlone) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    travelersController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleTravelingAlone(bool? value) {
    if (value == null) return;
    setState(() {
      travelingAlone = value;
      if (!travelingAlone) {
        _animationController.forward();
        widget.schedule.travelerNum = 2;
        travelersController.text = '2';
      } else {
        _animationController.reverse();
        widget.schedule.travelerNum = 1;
        travelersController.text = '1';
      }
    });
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
                'Budget',
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
                'Price range',
                style: GoogleFonts.rubik(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Minimum',
                          style: GoogleFonts.rubik(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            Positioned(
                              left: 12,
                              top: 16,
                              child: Text(
                                'USD \$',
                                style: GoogleFonts.rubik(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                            TextField(
                              controller: minPriceController,
                              decoration: InputDecoration(
                                prefixText: 'USD \$',
                                prefixStyle: GoogleFonts.rubik(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.transparent,
                                ),
                                hintText: '__',
                                filled: true,
                                fillColor:
                                    const Color(0xff18AFBA).withOpacity(0.5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 12.0,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.rubik(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color: Color(0xff18AFBA),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Maximum',
                          style: GoogleFonts.rubik(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            Positioned(
                              left: 12,
                              top: 16,
                              child: Text(
                                'USD \$',
                                style: GoogleFonts.rubik(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                            TextField(
                              controller: maxPriceController,
                              decoration: InputDecoration(
                                prefixText: 'USD \$',
                                prefixStyle: GoogleFonts.rubik(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.transparent,
                                ),
                                hintText: '__',
                                filled: true,
                                fillColor:
                                    const Color(0xff18AFBA).withOpacity(0.5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 12.0,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.rubik(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Choose spending habits for your trip',
                style: GoogleFonts.rubik(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildRadioButton('Budget friendly', 'Budget friendly',
                  'Stay conscious of costs'),
              _buildRadioButton(
                  'Moderate', 'Moderate', 'Keep costs on the average side'),
              _buildRadioButton(
                  'Luxury', 'Luxury', 'Don\'t worry about it – live a little!'),
              const SizedBox(height: 26),
              Text(
                'Will you be travelling alone?',
                style: GoogleFonts.rubik(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildTravelingAloneOption(),
              const SizedBox(height: 16),
              SlideTransition(
                position: _slideAnimation,
                child: travelingAlone
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Number of travelers in your trip',
                            style: GoogleFonts.rubik(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: travelersController,
                            decoration: InputDecoration(
                              hintText: 'Enter number of travelers',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 12.0,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.rubik(),
                            onChanged: (value) {
                              setState(() {
                                widget.schedule.travelerNum =
                                    int.tryParse(value) ?? 1;
                              });
                            },
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 36),
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
                      int minBudget =
                          int.tryParse(minPriceController.text) ?? 0;
                      int maxBudget =
                          int.tryParse(maxPriceController.text) ?? 0;
                      int travelers =
                          int.tryParse(travelersController.text) ?? 1;

                      if (minBudget > maxBudget) {
                        Get.snackbar(
                          'Invalid Budget',
                          'Minimum budget cannot be greater than maximum budget.',
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      widget.schedule.budget[0] = minBudget;
                      widget.schedule.budget[1] = maxBudget;
                      widget.schedule.travelerNum =
                          travelingAlone ? 1 : travelers;

                      Get.to(() => ReviewTripScreen(widget.schedule));
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
      ),
    );
  }

  Widget _buildRadioButton(String value, String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.schedule.budgetType = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: widget.schedule.budgetType == value
              ? const Color(0xffEF7168)
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: Radio<String>(
            value: value,
            groupValue: widget.schedule.budgetType,
            activeColor: Colors.white.withOpacity(0.7),
            onChanged: (String? newValue) {
              setState(() {
                widget.schedule.budgetType = newValue!;
              });
            },
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              title,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: widget.schedule.budgetType == value
                    ? Colors.white.withOpacity(0.8)
                    : Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              subtitle,
              style: GoogleFonts.rubik(
                fontSize: 14.0,
                color: widget.schedule.budgetType == value
                    ? Colors.white.withOpacity(0.8)
                    : Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTravelingAloneOption() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _toggleTravelingAlone(true),
            child: Container(
              decoration: BoxDecoration(
                color: travelingAlone
                    ? const Color(0xff18AFBA)
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: travelingAlone
                      ? const Color(0xff18AFBA)
                      : Colors.transparent,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Text(
                  'Yes',
                  style: GoogleFonts.rubik(
                    color: travelingAlone ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => _toggleTravelingAlone(false),
            child: Container(
              decoration: BoxDecoration(
                color: !travelingAlone
                    ? const Color(0xff18AFBA)
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: !travelingAlone
                      ? const Color(0xff18AFBA)
                      : Colors.transparent,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Text(
                  'No',
                  style: GoogleFonts.rubik(
                    color: !travelingAlone ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
