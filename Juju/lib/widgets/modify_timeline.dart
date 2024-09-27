// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:juju/model/places.dart';
import 'package:juju/widgets/add_location.dart';
import 'package:juju/util/const.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifyTimeline extends StatefulWidget {
  List<Place> placeList;
  final void Function(List<Place>) updatePlaceListFunc;
  final void Function(List<Place>, int) updateResultList;
  final int idx;

  ModifyTimeline({
    super.key,
    required this.placeList,
    required this.updatePlaceListFunc,
    required this.idx,
    required this.updateResultList,
  });

  @override
  State<ModifyTimeline> createState() => _ModifyTimelineState();
}

class _ModifyTimelineState extends State<ModifyTimeline> {
  void updateNewList(List<Place> newList) {
    setState(() {
      widget.placeList = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        title: Text(
          'Modify Timeline',
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
            Get.back(result: widget.placeList);
          },
        ),
        backgroundColor: Constants.header,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(
                  () => AddLocation(
                    newList: widget.placeList,
                    updateNewList: updateNewList,
                    updateOriginalList: widget.updatePlaceListFunc,
                    idx: widget.idx,
                    updateResultList: widget.updateResultList,
                  ),
                  transition: Transition.rightToLeftWithFade,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Constants.header),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    'Add or Remove Attractions',
                    style: GoogleFonts.rubik(
                      color: Constants.darkText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: Icon(
                    Icons.add_circle_outline_outlined,
                    color: Constants.header,
                    size: 28,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Constants.header,
                    size: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ReorderableListView.builder(
                itemCount: widget.placeList.length,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemBuilder: (BuildContext context, int index) {
                  final item = widget.placeList[index];
                  return Container(
                    key: ValueKey(item.id),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 4.0),
                    child: ListTile(
                      title: Text(
                        item.name,
                        style: GoogleFonts.rubik(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: Icon(
                        Icons.drag_handle,
                        color: Constants.header,
                      ),
                      trailing: Icon(
                        Icons.drag_indicator,
                        color: Constants.header,
                      ),
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final Place item = widget.placeList.removeAt(oldIndex);
                    widget.placeList.insert(newIndex, item);
                    widget.updatePlaceListFunc(widget.placeList);
                    widget.updateResultList(widget.placeList, widget.idx);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
