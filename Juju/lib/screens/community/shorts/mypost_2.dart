import 'package:flutter/material.dart';
import 'package:juju/screens/community/shorts/post_template.dart';

class MyPost2 extends StatelessWidget {
  const MyPost2({super.key});

  @override
  Widget build(BuildContext context) {
    return PostTemplate(
      username: 'zuckerberg',
      videoDescription: 'reels for days',
      numberOfLikes: '1.2M',
      numberOfComments: '232',
      numberOfShares: '122',
            userPost: Image.asset('assets/vid.gif',
        fit: BoxFit.contain,

      ),
    );
  }
}
