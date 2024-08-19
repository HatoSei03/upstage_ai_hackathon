import 'package:flutter/material.dart';
import 'package:stour/util/const.dart';
import 'package:stour/util/places.dart';
import 'package:stour/widgets/timeline_day.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stour/screens/chatbot.dart';

// ignore: must_be_immutable
class ViewSavedTour extends StatefulWidget {
  SavedTourClass savedTour;
  ViewSavedTour({required this.savedTour, super.key});
  @override
  State<ViewSavedTour> createState() => _ViewSavedTourState();
}

class _ViewSavedTourState extends State<ViewSavedTour> {
  void updateResultList(List<Place> newList, int idx) {
    setState(() {
      widget.savedTour.addedPlaces[idx] = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalMoney = 0;
    for (int i = 0; i < widget.savedTour.addedPlaces.length; i++) {
      for (int j = 0; j < widget.savedTour.addedPlaces[i].length; j++) {
        totalMoney += widget.savedTour.addedPlaces[i][j].price;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.header,
        title: Text(
          widget.savedTour.name,
          style: TextStyle(
            color: Constants.lightText,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Constants.lightText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.maxFinite,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Overall Information',
                        style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Days: ${widget.savedTour.addedPlaces.length}',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Budget: ${totalMoney.toStringAsFixed(0)}₫',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
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
              itemCount: widget.savedTour.addedPlaces.length,
              itemBuilder: (ctx, idx) {
                return Expanded(
                    child: TimelineDay(widget.savedTour.addedPlaces[idx],
                        idx + 1, updateResultList));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatbotSupportScreen(),
            ),
          );
        },
        tooltip: 'Floating Action Button',
        backgroundColor: Constants.header,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 2.0,
        child: Icon(
          Icons.question_answer,
          color: Constants.lightText2,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
