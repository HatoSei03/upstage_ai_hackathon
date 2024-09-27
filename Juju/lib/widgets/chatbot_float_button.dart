import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juju/util/const.dart';
import 'package:juju/screens/chatbot.dart';

class ChatbotFloatButton extends StatelessWidget {
  const ChatbotFloatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.to(
          const ChatbotSupportScreen(),
          transition: Transition.zoom,
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
    );
  }
}
