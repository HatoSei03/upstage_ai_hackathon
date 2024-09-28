import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class SwipableCard {
  final String imageUrl;
  final String name;
  final String location;
  final String dates;
  final String briefDescription;
  final String tips;
  final String keywords;

  SwipableCard(
    this.imageUrl,
    this.name,
    this.location,
    this.dates,
    this.briefDescription,
    this.tips,
    this.keywords,
  );
}

class SwipeableCards extends StatefulWidget {
  final List<SwipableCard> placeList;

  const SwipeableCards(this.placeList, {super.key});

  @override
  _SwipeableCardsState createState() => _SwipeableCardsState();
}

class _SwipeableCardsState extends State<SwipeableCards> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  void _showModal(BuildContext context, SwipableCard card) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              card.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            card.name,
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Color(0xffFF9680),
                            ),
                            const SizedBox(width: 4),
                            SizedBox(
                              width: 240,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  card.location,
                                  style: GoogleFonts.montserrat(
                                    color: Color(0xff39414B),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(height: 10),
                          Text(
                            card.briefDescription,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none, // Added
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Event Time',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              decoration: TextDecoration.none,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            card.dates,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Useful Tips',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            card.tips,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Keywords',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 18,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            card.keywords,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.placeList.length,
          itemBuilder: (context, index, realIndex) {
            final card = widget.placeList[index];
            return GestureDetector(
              onTap: () {
                _showModal(context, card);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.9),
                        blurRadius: 6,
                        offset: const Offset(0, 7),
                        spreadRadius: -5),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32.0),
                  child: Stack(
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: 'assets/localImage/placeholder.png',
                        image: card.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                card.name,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                card.location,
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xffF3F3F3),
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            enableInfiniteScroll: true,
            pauseAutoPlayOnTouch: true,
            scrollPhysics: const BouncingScrollPhysics(),
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.placeList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? const Color(0xffEF7168)
                      : const Color(0xffDBE0E7),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
