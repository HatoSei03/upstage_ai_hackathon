import 'package:flutter/material.dart';
import 'package:juju/model/schedule.dart';
import 'package:juju/util/const.dart';
import 'package:juju/model/places.dart';
import 'package:juju/widgets/timeline_day.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:juju/widgets/chatbot_float_button.dart';

class ViewSavedTour extends StatefulWidget {
  Schedule savedTour;
  ViewSavedTour(this.savedTour, {super.key});

  @override
  State<ViewSavedTour> createState() => _ViewSavedTourState();
}

class _ViewSavedTourState extends State<ViewSavedTour> {
  void updateResultList(List<Place> newList, int idx) {
    setState(() {
      widget.savedTour.places[idx] = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalMoney = 0;
    for (int i = 0; i < widget.savedTour.places.length; i++) {
      for (int j = 0; j < widget.savedTour.places[i].length; j++) {
        totalMoney += widget.savedTour.places[i][j].price;
      }
    }

    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        title: Text(
          widget.savedTour.name,
          style: GoogleFonts.rubik(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back(result: widget.savedTour);
          },
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.maxFinite,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall Information',
                        style: GoogleFonts.rubik(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Days: ${widget.savedTour.places.length}',
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Budget: ${totalMoney.toStringAsFixed(0)}\$',
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.savedTour.places.length,
              itemBuilder: (ctx, idx) {
                return TimelineDay(
                  widget.savedTour.places[idx],
                  idx + 1,
                  updateResultList,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const ChatbotFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
