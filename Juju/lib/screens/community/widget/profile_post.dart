import 'package:flutter/material.dart';
import 'package:juju/util/const.dart';
import 'package:google_fonts/google_fonts.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final List<int> _images = [1, 2, 3];
  List<String> tag = ["Urban", "Shopping", "Sightseeing", "Beautiful"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _images.map((e) {
        return buildPost(context);
      }).toList(),
    );
  }

  Container buildPost(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: Constants.background,
        margin: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            "https://i.pinimg.com/236x/0a/b5/9e/0ab59e7c8e7a1213ff1ee891e98e06ae.jpg?nii=t"),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hato",
                                style: GoogleFonts.rubik(
                                  color: Color(0xFF545454),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                "2 months ago",
                                style: GoogleFonts.rubik(
                                  color: Color(0xff545454),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Thoroughly enjoyed my trip 💕💕',
                            style: GoogleFonts.rubik(
                              fontSize: 17,
                            ),
                          ),
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
                                  "Jeju Island, South Korea",
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xff39414B),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              child: Card(
                elevation: 0,
                semanticContainer: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  "assets/localImg/Manjanggul-Lava-Tube.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              height: 251,
              child: Text(
                """
Stepping into Manjanggul is like time traveling millions of years back. This massive lava tube is an awe-inspiring testament to nature's raw power. The sheer scale of the cavern is mind-boggling, and the unique rock formations are truly captivating. It's a must-see for anyone visiting Jeju Island. Just remember to wear comfortable shoes, as the path can be uneven.

#Manjanggul #JejuIsland #LavaTube #NatureWonders #TravelKorea
""",
                style: GoogleFonts.rubik(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6.0,
                    runSpacing: -8.0,
                    children: tag
                        .map(
                          (tag) => Chip(
                            label: Text(
                              tag,
                              style: GoogleFonts.rubik(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 14,
                              ),
                            ),
                            backgroundColor: const Color(0xffF8D8B8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            side: BorderSide.none,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Budget",
                        style: GoogleFonts.rubik(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "US \$800",
                        style: GoogleFonts.rubik(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff18AFBA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "View Itinerary",
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.favorite_outline,
                            color: Color.fromARGB(255, 255, 12, 109)),
                        SizedBox(width: 5),
                        Text("123"),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.comment_outlined, color: Constants.header),
                        const SizedBox(width: 5),
                        const Text("123"),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.share_outlined, color: Constants.darkText),
                        const SizedBox(width: 5),
                        const Text("1"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
