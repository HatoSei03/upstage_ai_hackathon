import 'package:flutter/material.dart';
import 'package:juju/screens/community/shorts/post_template.dart';

class MyPost1 extends StatelessWidget {
  const MyPost1({super.key});

  @override
  Widget build(BuildContext context) {
    return PostTemplate(
      username: 'createdbykoko',
      videoDescription: 'tiktok ui tutorial',
      numberOfLikes: '1.2M',
      numberOfComments: '1232',
      numberOfShares: '122',
      userPost: Container(
        color: Colors.deepPurple[300],
      ),
    );
  }
}
