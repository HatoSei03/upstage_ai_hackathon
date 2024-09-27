// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/util/const.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:juju/widgets/rating_bar.dart';
import 'package:juju/model/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juju/screens/details/create_review_screen.dart';
import 'package:juju/model/places.dart';

class ReviewsScreen extends StatelessWidget {
  final String locationID;
  const ReviewsScreen({super.key, required this.locationID});

  Future<List<DocumentSnapshot>> _fetchReviews() async {
    ReviewsServices rs = ReviewsServices();
    return await rs.getAllReviewsByItemID(locationID);
  }

  @override
  Widget build(BuildContext context) {
    String currentRating =
        places.firstWhere((element) => element.id == locationID).rating;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.background,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Constants.demoBlue,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: Constants.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 4,
        ),
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: _fetchReviews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching reviews'));
            } else {
              List<DocumentSnapshot> reviews = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(currentRating),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Color(0xffEF7168)),
                          shape: WidgetStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          IconsaxPlusLinear.filter,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  if (reviews.isEmpty)
                    Center(
                      child: Text(
                        'No reviews yet',
                        style: GoogleFonts.rubik(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        var data =
                            reviews[index].data() as Map<String, dynamic>;
                        return _buildReviewCard(
                          name: data['name'] ?? 'Anonymous',
                          date: data['createdAt'] != null
                              ? data['createdAt'].toString().split(' ')[0]
                              : '',
                          reviewText: data['content'] ?? '',
                          likes: data['likes'] ?? 0,
                          dislikes: data['dislikes'] ?? 0,
                          images: data['images'] != null
                              ? List<String>.from(data['images'])
                              : [],
                          isLiked: false,
                        );
                      },
                    ),
                  ),
                  if (reviews.isNotEmpty)
                    Center(
                      child: Text(
                        'That\'s all we currently have!',
                        style: GoogleFonts.rubik(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  Spacer(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeader(String currentRating) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: AssetImage('assets/localImg/Background.png'),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          height: 204,
          width: 234,
          child: Stack(
            children: [
              Positioned(
                left: 20,
                top: 19,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reviews',
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 160,
                      child: Text(
                        'Rating for this location',
                        style: GoogleFonts.rubik(
                          color: const Color.fromRGBO(255, 255, 255, 0.7),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(
                            () => CreateReviewScreen(locationID: locationID));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.demoRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        'Write your review',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          height: 204,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 117,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: Constants.demoTealNoTrans,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 6),
                        Text(
                          currentRating,
                          style: GoogleFonts.rubik(
                            color: Constants.demoBlackText,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.star_rounded,
                          color: Constants.demoStar,
                          size: 34,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 22,
                          decoration: BoxDecoration(
                            color: Constants.demoTealNoTrans,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              5,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.5),
                                  child: Icon(
                                    Icons.star_rounded,
                                    color: index < 4
                                        ? const Color(0xFFFFEB0E)
                                        : Colors.white,
                                    size: 14,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Wow',
                          style: GoogleFonts.rubik(
                            color: Constants.demoBlackText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 9),
                        SizedBox(
                          width: 100,
                          child: Text(
                            '1000+ travellers love this place',
                            style: GoogleFonts.rubik(
                              color: const Color(0xff619496),
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard({
    required String name,
    required String date,
    required String reviewText,
    required int likes,
    required int dislikes,
    required List<String> images,
    required bool isLiked,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Constants.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 363.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 3,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.tealAccent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/splash_screen.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.rubik(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              date,
                              style: GoogleFonts.rubik(
                                color: Constants.demoGrey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    LikeColumn(
                      disliked: false,
                      liked: false,
                      numDislikes: dislikes,
                      numLikes: likes,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 363.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBar(
                  rating: 5,
                  reviewCount: 3000,
                  displayText: false,
                ),
                ImageRow(
                  images: images,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            reviewText,
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class LikeColumn extends StatefulWidget {
  bool liked;
  bool disliked;
  int numLikes;
  int numDislikes;

  LikeColumn({
    required this.liked,
    required this.disliked,
    required this.numLikes,
    required this.numDislikes,
    super.key,
  });

  @override
  _LikeColumnState createState() => _LikeColumnState();
}

class _LikeColumnState extends State<LikeColumn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.liked = !widget.liked;
                  if (widget.disliked) {
                    widget.disliked = false;
                    widget.numDislikes--;
                  }
                  widget.numLikes += widget.liked ? 1 : -1;
                });
              },
              icon: Icon(
                Icons.thumb_up_alt_rounded,
                color: widget.liked ? Constants.demoRed : Constants.demoGrey,
                size: 18,
              ),
            ),
            Text(
              '${widget.numLikes}',
              style: GoogleFonts.rubik(
                color: Constants.demoGrey,
                fontSize: 14,
                height: 0.1,
              ),
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.disliked = !widget.disliked;
                  if (widget.liked) {
                    widget.liked = false;
                    widget.numLikes--;
                  }
                  widget.numDislikes += widget.disliked ? 1 : -1;
                });
              },
              icon: Icon(
                Icons.thumb_down_alt_rounded,
                color: widget.disliked ? Constants.demoRed : Constants.demoGrey,
                size: 18,
              ),
            ),
            Text(
              '${widget.numDislikes}',
              style: GoogleFonts.rubik(
                color: Constants.demoGrey,
                fontSize: 14,
                height: 0.1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ImageRow extends StatelessWidget {
  final List<String> images;

  const ImageRow({this.images = const [], super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: images.map((image) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                Image.network(image, width: 40, height: 40, fit: BoxFit.cover),
          ),
        );
      }).toList(),
    );
  }
}
