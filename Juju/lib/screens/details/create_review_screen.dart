import 'package:flutter/material.dart';
import 'package:juju/model/review.dart';
import 'package:juju/util/const.dart';

class CreateReviewScreen extends StatefulWidget {
  final String locationID;
  const CreateReviewScreen({super.key, required this.locationID});
  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  int selectedStars = 5;
  TextEditingController commentController = TextEditingController();
  ReviewsServices rs = ReviewsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Review',
          style: TextStyle(
              color: Constants.lightText, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Constants.header,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Constants.lightText),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate This Attraction:',
              style: TextStyle(
                  color: Color.fromARGB(255, 35, 52, 10),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                buildStarButton(1),
                buildStarButton(2),
                buildStarButton(3),
                buildStarButton(4),
                buildStarButton(5),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Review:',
              style: TextStyle(
                  color: Constants.lightText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Leave your impression here.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.header,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Constants.lightText,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    rs.createReview(
                        'review 2511111',
                        'abc',
                        widget.locationID,
                        'Võ Minh Khôi',
                        'https://i.imgur.com/xZ5946b.jpeg',
                        commentController.text,
                        selectedStars.toString());
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.header,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: Text(
                    'Post',
                    style: TextStyle(color: Constants.lightText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStarButton(int stars) {
    return IconButton(
      onPressed: () {
        setState(() {
          selectedStars = stars;
        });
      },
      icon: Icon(
        stars <= selectedStars ? Icons.star : Icons.star_border,
        size: 30,
        color: Colors.amber,
      ),
    );
  }
}
