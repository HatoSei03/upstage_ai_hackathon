import 'package:flutter/material.dart';
import 'package:juju/screens/community/shorts/post_template.dart';

class MyPost3 extends StatelessWidget {
  const MyPost3({super.key});

  @override
  Widget build(BuildContext context) {
    return PostTemplate(
      username: 'randomUser',
      videoDescription: 'flutter tutorial',
      numberOfLikes: '1.2B',
      numberOfComments: '232',
      numberOfShares: '122',
      userPost: Image.asset(
        "assets/vid.gif",
        fit: BoxFit.contain,
      ),
    );
  }
}
