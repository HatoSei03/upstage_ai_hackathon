import 'package:flutter/material.dart';
import 'package:juju/model/places.dart';
import 'package:juju/screens/details/details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class PlaceCard extends StatefulWidget {
  final Place place;

  const PlaceCard({
    super.key,
    required this.place,
  });

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: SizedBox(
        width: 230,
        child: GestureDetector(
          onTap: () {
            Get.to(
              () => DetailsScreen(widget.place),
              transition: Transition.zoom,
            );
          },
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 3.0,
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 10),
                              spreadRadius: -8,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                            height: 130,
                            width: MediaQuery.of(context).size.width,
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/localImg/placeholder.jpg',
                              image: widget.place.img[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      right: 10.0,
                      child: IconButton(
                        iconSize: 20.0,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 30,
                          minHeight: 30,
                        ),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.white.withOpacity(0.3)),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  widget.place.name,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: const Color(0xff0A2753),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Stack(children: [
                              Positioned(
                                top: 3,
                                child: Icon(BoxIcons.bxs_map,
                                    size: 14,
                                    color: const Color(0xffEF7168)
                                        .withOpacity(0.5)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      widget.place.address,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                        color: const Color(0xff6A778B),
                                      ),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xffFFEB0E),
                            size: 16,
                          ),
                          Text(
                            widget.place.rating.toString(),
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
