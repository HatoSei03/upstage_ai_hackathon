import 'package:flutter/material.dart';
import 'package:juju/model/places.dart';
import 'package:juju/util/const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AddLocation extends StatefulWidget {
  List<Place> newList = [];
  final void Function(List<Place>) updateNewList;
  final void Function(List<Place>) updateOriginalList;
  final void Function(List<Place>, int) updateResultList;
  final int idx;

  AddLocation(
      {required this.newList,
      required this.updateNewList,
      required this.updateOriginalList,
      required this.idx,
      required this.updateResultList,
      super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Location',
          style: GoogleFonts.rubik(
            color: Constants.lightText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Constants.lightText,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Constants.header,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Add or remove attractions from your tour:',
                  style: GoogleFonts.rubik(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    places[index].name,
                    style: GoogleFonts.rubik(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  activeColor: Constants.header,
                  checkColor: Colors.white,
                  value: widget.newList.contains(places[index]),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        if (!widget.newList.contains(places[index])) {
                          widget.newList.add(places[index]);
                          widget.updateNewList(widget.newList);
                          widget.updateOriginalList(widget.newList);
                          widget.updateResultList(widget.newList, widget.idx);
                        }
                      } else {
                        widget.newList.remove(places[index]);
                        widget.updateNewList(widget.newList);
                        widget.updateOriginalList(widget.newList);
                        widget.updateResultList(widget.newList, widget.idx);
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Constants.background,
    );
  }
}
