import 'package:flutter/material.dart';
import 'package:juju/screens/community/shorts/mypost_1.dart';
import 'package:juju/screens/community/shorts/mypost_2.dart';
import 'package:juju/screens/community/shorts/mypost_3.dart';

class Reel extends StatelessWidget {
  final _controller = PageController(initialPage: 0);

  Reel({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.vertical,
      children: const [
        MyPost1(),
        MyPost2(),
        MyPost3(),
      ],
    );
  }
}
