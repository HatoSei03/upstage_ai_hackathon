import 'package:flutter/material.dart';
import 'package:juju/screens/details/details.dart';
import 'package:juju/util/const.dart';
import 'package:juju/model/places.dart';
import 'package:get/get.dart';

class TrendingPlace extends StatefulWidget {
  final Place place;

  const TrendingPlace({
    super.key,
    required this.place,
  });

  @override
  State<TrendingPlace> createState() => _TrendingPlaceState();
}

class _TrendingPlaceState extends State<TrendingPlace> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => DetailsScreen(widget.place),
          transition: Transition.zoom,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 3.0,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/localImg/placeholder.jpg',
                            image: widget.place.img[0],
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned(
                      top: 6.0,
                      right: 6.0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Constants.ratingBG,
                                size: 10.0,
                              ),
                              Text(
                                " ${widget.place.rating} ",
                                style: const TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6.0,
                      left: 6.0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            " ${widget.place.opentime.toString()}-${widget.place.closetime.toString()}",
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        widget.place.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.place.address,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
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
