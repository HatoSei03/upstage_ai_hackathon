import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stour/util/const.dart';
import 'package:stour/util/places.dart';
import 'package:flutter/services.dart';
import 'package:stour/screens/review_screen.dart';
import 'package:stour/screens/chatbot.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.placeToDisplay});
  final Place placeToDisplay;

  @override
  State<DetailScreen> createState() {
    return _DetailScreenState();
  }
}

class _DetailScreenState extends State<DetailScreen> {
  bool hasLiked = false;
  Color buttonColor = Colors.black;
  Icon initialFavIcon = const Icon(Icons.favorite_border, size: 30);
  bool isContactInfoExpanded = false; // Add this variable

  @override
  Widget build(context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 25),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Details',
                  style: GoogleFonts.poppins(
                      color: Constants.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                IconButton(
                  onPressed: () {
                    return setState(
                      () {
                        hasLiked = !hasLiked;
                        buttonColor = (hasLiked)
                            ? const Color.fromARGB(255, 255, 12, 109)
                            : Colors.black;
                        initialFavIcon = (hasLiked)
                            ? const Icon(Icons.favorite, size: 30)
                            : const Icon(Icons.favorite_border, size: 30);
                      },
                    );
                  },
                  icon: initialFavIcon,
                  color: buttonColor,
                ),
              ],
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.placeToDisplay.img,
                width: double.maxFinite,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isContactInfoExpanded = !isContactInfoExpanded;
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          widget.placeToDisplay.name,
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      isContactInfoExpanded
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isContactInfoExpanded
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.language,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () async {
                                  final url = widget.placeToDisplay.website;
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Text(
                                  widget.placeToDisplay.website,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 19, 81, 133)),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.placeToDisplay.contact,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Constants.textColor,
                    size: 25,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        widget.placeToDisplay.address,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Constants.textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                              '${widget.placeToDisplay.price.toStringAsFixed(0)}\$',
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.time,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                              '${widget.placeToDisplay.opentime.toStringAsFixed(0)}h - ${widget.placeToDisplay.closetime.toStringAsFixed(0)}h',
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewScreen(
                                locationID: widget.placeToDisplay.id),
                          ),
                        );
                      },
                      child: Text(
                        'Leave a Review',
                        style: TextStyle(color: Constants.textColor),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    widget.placeToDisplay.history,
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: Constants.textColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatbotSupportScreen(),
            ),
          );
        },
        tooltip: 'Floating Action Button',
        backgroundColor: Constants.highlight, // Custom color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Round shape
        ),
        elevation: 2.0,
        child: const Icon(Icons.question_answer),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
