import 'package:juju/model/schedule.dart';

class Place {
  String id;
  final String name;
  final String address;
  final String rating;
  final List<String> img;
  final List<String> tag;
  final num price;
  final String history;
  final num opentime;
  final num closetime;
  final String website;
  final String contact;
  final double long;
  final double lat;

  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.img,
    required this.tag,
    required this.price,
    required this.history,
    required this.opentime,
    required this.closetime,
    required this.website,
    required this.contact,
    required this.long,
    required this.lat,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'rating': rating,
      'img': img,
      'tag': tag,
      'price': price,
      'history': history,
      'opentime': opentime,
      'closetime': closetime,
      'website': website,
      'contact': contact,
      'long': long,
      'lat': lat,
    };
  }
}


List<Place> places = [];
List<Place> food = [];
List<List<dynamic>> savedTour = [];
