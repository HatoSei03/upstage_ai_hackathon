// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:juju/model/places.dart';
import 'package:juju/widgets/modify_timeline.dart';
import 'package:get/get.dart';
import 'package:juju/widgets/place_card.dart';
import 'package:google_fonts/google_fonts.dart';

class TimelineDay extends StatefulWidget {
  List<Place> placesToGo;
  final int dayNum;
  final void Function(List<Place>, int) updateResultList;
  TimelineDay(this.placesToGo, this.dayNum, this.updateResultList, {super.key});
  @override
  State<TimelineDay> createState() {
    return _TimelineDayState();
  }
}

class _TimelineDayState extends State<TimelineDay> {
  final TextEditingController tourNameController = TextEditingController();
  void _updatePlaceList(List<Place> newList) {
    setState(() {
      widget.placesToGo = newList;
      widget.updateResultList(
          newList, widget.dayNum - 1); // Ensure the parent is updated
    });
  }

  Widget buildPlaceList(BuildContext context, List<Place> source) {
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: source.length,
        itemBuilder: (BuildContext context, int index) {
          Place place = source[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PlaceCard(place: place),
          );
        },
      ),
    );
  }

  @override
  Widget build(context) {
    double totalCost = 0;
    for (int i = 0; i < widget.placesToGo.length; i++) {
      totalCost += widget.placesToGo[i].price;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Day ${widget.dayNum} - ${totalCost.toStringAsFixed(0)}\$',
                style: GoogleFonts.rubik(
                  // Changed from default TextStyle to Rubik
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black, // Updated text color to match app style
                ),
              ),
              TextButton(
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: () {
                  Get.to(
                    () => ModifyTimeline(
                      placeList: widget.placesToGo,
                      updatePlaceListFunc: _updatePlaceList,
                      updateResultList: widget.updateResultList,
                      idx: widget.dayNum - 1,
                    ),
                    transition: Transition.rightToLeftWithFade,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 5),
          buildPlaceList(context, widget.placesToGo),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
