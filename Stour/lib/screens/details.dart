import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stour/util/const.dart';
import 'package:stour/util/places.dart';
import 'package:flutter/services.dart';
import 'package:stour/screens/review_screen.dart';
import 'package:stour/screens/chatbot.dart';

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
                      color: Constants.paletteDark,
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
              child: Text(
                widget.placeToDisplay.name,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Constants.palette2,
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
                          color: Constants.palette2,
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
                              '${widget.placeToDisplay.price.toStringAsFixed(0)}₫',
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
                              '${widget.placeToDisplay.openTime.toStringAsFixed(0)}h - ${widget.placeToDisplay.closeTime.toStringAsFixed(0)}h',
                              style: const TextStyle(fontSize: 16))
                        ],
                      )
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
                        style: TextStyle(color: Constants.palette1),
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
                        fontSize: 18, color: Constants.paletteDark),
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
        backgroundColor: Constants.palette3, // Custom color
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
