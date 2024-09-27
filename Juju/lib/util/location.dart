import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<String> currentLocationDetail = [];
LatLng currentLocation = venueLocation;
LatLng venueLocation = const LatLng(33.512, 126.494);

class LocationController {
  LatLng center = venueLocation;
  Set<Marker> markers = {};
  Position? currentPosition;

  LocationController() {
    init();
  }

  Future<void> init() async {
    currentPosition = await determinePosition();
    if (currentPosition != null) {
      center = LatLng(currentPosition!.latitude, currentPosition!.longitude);
      getUserAddress(currentPosition!);
      currentLocation = center;
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<List<String>> getAddressInfoFromPosition(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks.first;
    String country = placemark.country ?? "";
    String district = (placemark.subAdministrativeArea) ?? "";
    String city = placemark.administrativeArea ?? "";
    return [district, city, country];
  }

  void getUserAddress(Position src) async {
    currentLocationDetail = await getAddressInfoFromPosition(src);
  }
}
