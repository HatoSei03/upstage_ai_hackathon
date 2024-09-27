import 'package:flutter/material.dart';
import 'package:juju/model/places.dart';
import 'package:intl/intl.dart';
import 'package:juju/model/schedule.dart';
import 'package:juju/screens/schedule/view_saved_tour.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/util/const.dart';
import 'package:get/get.dart';
import 'package:juju/widgets/chatbot_float_button.dart';

class SavedTour extends StatefulWidget {
  const SavedTour({super.key});
  @override
  State<SavedTour> createState() {
    return _SavedTourState();
  }
}

class _SavedTourState extends State<SavedTour> {
  final TextEditingController _tourNameController = TextEditingController();

  void _showRenameDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rename'),
          content: TextField(
            controller: _tourNameController,
            decoration: const InputDecoration(hintText: 'New name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color.fromARGB(255, 35, 52, 10),
                ),
              ),
              onPressed: () {
                _tourNameController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save',
                  style: TextStyle(
                    color: Color.fromARGB(255, 35, 52, 10),
                  )),
              onPressed: () {
                setState(
                  () {
                    savedTour[index].name = _tourNameController.text;
                    _tourNameController.clear();
                  },
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showContextMenu(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Column(
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(
                  'Rename',
                  style: TextStyle(
                    color: Color.fromARGB(255, 35, 52, 10),
                  ),
                ),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _showRenameDialog(context, index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text(
                  'Delete Tour',
                  style: TextStyle(
                    color: Color.fromARGB(255, 35, 52, 10),
                  ),
                ),
                onTap: () {
                  Navigator.of(ctx).pop();
                  setState(() {
                    savedTour.removeAt(index);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(context) {
    if (savedTour.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Saved Tours',
            style: TextStyle(
              color: Constants.lightText,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Constants.header,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Constants.lightText,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Is anybody there?',
                  style: GoogleFonts.roboto(
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30),
                Text('Looks like you have not created any tours yet.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 35, 52, 10),
                      fontSize: 16,
                    )),
                const SizedBox(height: 20),
                Text(
                  'Try creating a new tour customized to your needs using our Initerary Planner.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: const Color.fromARGB(255, 35, 52, 10),
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: const ChatbotFloatButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Tours',
          style: TextStyle(
            color: Constants.lightText,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Constants.header,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Constants.lightText,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: savedTour.length,
        itemBuilder: (BuildContext context, int index) {
          Schedule tour = savedTour[index];
          return ListTile(
            title: Text(tour.name,
                style: const TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(
                'Created in: ${DateFormat.yMd().format(tour.createdDate)}'),
            onTap: () {
              Get.to(
                () => ViewSavedTour(savedTour[index]),
                transition: Transition.zoom,
              );
            },
            onLongPress: () {
              _showContextMenu(context, index);
            },
          );
        },
      ),
      floatingActionButton: const ChatbotFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
