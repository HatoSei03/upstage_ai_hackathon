import 'package:flutter/material.dart';
import 'package:stour/model/review.dart';
import 'package:stour/util/const.dart';
import 'package:stour/util/reviews.dart';
import 'package:stour/screens/create_review_screen.dart';
import 'package:stour/model/ui_reviews.dart';

class ReviewScreen extends StatefulWidget {
  final String locationID;
  const ReviewScreen({super.key, required this.locationID});
  @override
  State<ReviewScreen> createState() => _ReviewScreenState<Reviews>();
}

class _ReviewScreenState<Reviews> extends State<ReviewScreen> {
  ReviewsServices rs = ReviewsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reviews',
          style: TextStyle(
            color: Constants.lightText2,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Constants.lightText2,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Constants.header,
      ),
      body:
          Center(child: GetUIAllReviewsByItemID(locationID: widget.locationID)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newReview = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateReviewScreen(locationID: widget.locationID),
            ),
          );
          if (newReview != null) {
            setState(() {
              user.add(newReview);
            });
          }
        },
        backgroundColor: Constants.header,
        tooltip: "Leave a Review",
        child: Icon(Icons.add, color: Constants.lightText2),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
