import 'package:juju/util/const.dart';
import 'package:juju/widgets/profile_img.dart';
import 'package:juju/widgets/profile_option.dart';
import 'package:flutter/material.dart';
import 'package:juju/screens/community/widget/profile_post.dart';
import 'package:juju/screens/saved_tour.dart';
import 'package:get/get.dart';
import 'package:juju/widgets/chatbot_float_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final int _selectedEvent = 0;

  final List<Widget> _pages = [const PostScreen()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileImage(size),
                profileInfo(),
                profileActivity(),
                profileEvents(size),
                _pages[_selectedEvent],
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const ChatbotFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Container profileEvents(Size size) {
    return Container(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: size.width / 3.6,
              padding: const EdgeInsets.all(8),
              child: MaterialButton(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide(color: Constants.darkText)),
                color: _selectedEvent == 1 ? Constants.darkText : Colors.white,
                onPressed: () {},
                child: Text("POST",
                    style: TextStyle(
                      color: _selectedEvent == 1
                          ? Constants.lightText
                          : const Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: size.width / 3.6,
              padding: const EdgeInsets.all(8),
              child: MaterialButton(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: BorderSide(color: Constants.darkText)),
                color: _selectedEvent == 1 ? Constants.darkText : Colors.white,
                onPressed: () {
                  Get.to(
                    const SavedTour(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Text("YOUR TOURS",
                    style: TextStyle(
                      color: _selectedEvent == 1
                          ? Constants.lightText
                          : const Color.fromARGB(255, 0, 0, 0),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Container profileInfo() {
  return Container(
    padding: EdgeInsets.zero,
    child: ListTile(
      title: const Row(
        children: [
          Text(
            "Hato",
            style: TextStyle(
                color: Color.fromARGB(255, 35, 52, 10),
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          SizedBox(
            width: 8,
          ),
        ],
      ),
      subtitle: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Row(
              children: [
                Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 35, 52, 10),
                ),
                Text(
                  "Jeju-si, South Korea",
                  style: TextStyle(
                      color: Color.fromARGB(255, 35, 52, 10), fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Row(
              children: [
                Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 35, 52, 10),
                ),
                Text(
                  "Bio",
                  style: TextStyle(
                      color: Color.fromARGB(255, 35, 52, 10), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
