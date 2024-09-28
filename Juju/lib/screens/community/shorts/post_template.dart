import 'package:flutter/material.dart';
import 'button.dart';

class PostTemplate extends StatelessWidget {
  final String username;
  final String videoDescription;
  final String numberOfLikes;
  final String numberOfComments;
  final String numberOfShares;
  final Widget userPost;

  const PostTemplate({
    super.key,
    required this.username,
    required this.videoDescription,
    required this.numberOfLikes,
    required this.numberOfComments,
    required this.numberOfShares,
    required this.userPost,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background to black
      body: Stack(
        children: [
          Center(
            child: Container(
              color: Colors.black, // Ensure the background remains black
              child: AspectRatio(
                aspectRatio: 9 / 16, // Typical vertical video aspect ratio
                child: userPost,
              ),
            ),
          ),
          // Post Information
          Positioned(
            bottom: 80, // Adjusted to ensure space for buttons
            left: 20,
            right: 100, // Leave space for buttons on the right
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('@$username',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    )),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: videoDescription,
                          style: const TextStyle(color: Colors.white)),
                      const TextSpan(
                          text: ' #fyp #flutter',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
          ),

          // Buttons
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  icon: Icons.favorite,
                  number: numberOfLikes,
                ),
                const SizedBox(height: 20),
                MyButton(
                  icon: Icons.chat_bubble_outlined,
                  number: numberOfComments,
                ),
                const SizedBox(height: 20),
                MyButton(
                  icon: Icons.send,
                  number: numberOfShares,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
