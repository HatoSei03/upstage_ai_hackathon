import 'dart:ui'; // Added for ImageFilter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/widgets/rating_bar.dart';
import 'package:get/get.dart';
import 'package:juju/widgets/image_slider.dart';
import 'package:flutter/services.dart';
import 'package:juju/model/places.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:juju/util/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:juju/screens/details/review_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:juju/widgets/chatbot_float_button.dart';

class DetailsScreen extends StatefulWidget {
  final Place place;
  const DetailsScreen(this.place, {super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isContactInfoExpanded = false;

  List<dynamic>? hourlyForecast;
  Map<String, dynamic>? dailyForecast;

  bool isLoadingWeather = true; // Added flag to check loading state

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Widget buildIconSection(String section, String data) {
    const icon = {
      'Open': Icons.access_time,
      'Distance': Icons.route_rounded,
      'Price': BoxIcons.bx_wallet_alt,
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon[section],
              color: const Color(0xff0B799E),
              size: 28,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              section,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              width: 60,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  data,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> fetchWeatherData() async {
    const String apiKey = 'aba693da5bb5d817515b660cc169d5a8';
    final lat = widget.place.lat;
    final lon = widget.place.long;

    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        hourlyForecast = data['list'].take(8).toList();
        dailyForecast = _processDailyForecast(data);
        isLoadingWeather = false;
      });
    } else {
      print("error while loading weather data");
      setState(() {
        isLoadingWeather = false;
      });
    }
  }

  Map<String, dynamic> _processDailyForecast(Map<String, dynamic> data) {
    Map<String, dynamic> dailyData = {};
    for (var item in data['list']) {
      String date = item['dt_txt'].split(' ')[0];
      if (!dailyData.containsKey(date)) {
        dailyData[date] = item;
      }
    }
    return dailyData;
  }

  void _showLocationModal() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.85,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xfffff9f3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target:
                                    LatLng(widget.place.lat, widget.place.long),
                                zoom: 14.0,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId(widget.place.name),
                                  position: LatLng(
                                      widget.place.lat, widget.place.long),
                                  infoWindow:
                                      InfoWindow(title: widget.place.name),
                                ),
                              },
                              myLocationEnabled: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Hourly Forecast',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              isLoadingWeather
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : hourlyForecast != null
                                      ? SizedBox(
                                          height: 120,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: hourlyForecast!.length,
                                            itemBuilder: (context, index) {
                                              var item = hourlyForecast![index];
                                              return _buildWeatherItem(item);
                                            },
                                          ),
                                        )
                                      : const Center(
                                          child: Text('No data available'),
                                        ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '7-Day Forecast',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              isLoadingWeather
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : dailyForecast != null
                                      ? SizedBox(
                                          height: 120,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                dailyForecast!.keys.length,
                                            itemBuilder: (context, index) {
                                              var key = dailyForecast!.keys
                                                  .elementAt(index);
                                              var item = dailyForecast![key];
                                              return _buildWeatherItem(item);
                                            },
                                          ),
                                        )
                                      : const Center(
                                          child: Text('No data available'),
                                        ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildWeatherItem(dynamic item) {
    DateTime dateTime = DateTime.parse(item['dt_txt']);
    String time = DateFormat.Hm().format(dateTime);
    String date = DateFormat.MMMd().format(dateTime);

    String iconCode = item['weather'][0]['icon'];
    String iconUrl = 'https://openweathermap.org/img/w/$iconCode.png';

    return Card(
      color: const Color(0xff8bd4d6),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: GoogleFonts.montserrat(fontSize: 12),
            ),
            Image.network(
              iconUrl,
              width: 40,
              height: 40,
            ),
            Text(
              '${item['main']['temp'].toInt()}°C',
              style: GoogleFonts.montserrat(fontSize: 14),
            ),
            Text(
              date,
              style: GoogleFonts.montserrat(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return Scaffold(
      backgroundColor: const Color(0xfffff9f3),
      appBar: AppBar(
        backgroundColor: Constants.background,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Details',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w600,
                  fontSize: 32.0,
                ),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
          child: IconButton(
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Constants.backArrow,
              size: 26,
            ),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            ImageSlider(
              imageUrls: widget.place.img,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isContactInfoExpanded = !isContactInfoExpanded;
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 338,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  widget.place.name,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
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
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: isContactInfoExpanded
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.language,
                                      size: 16,
                                      color: Color(0xff0B799E),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: GestureDetector(
                                          onTap: () async {
                                            final url = widget.place.website;
                                            if (await canLaunchUrl(
                                                Uri.parse(url))) {
                                              await launchUrl(Uri.parse(url));
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          },
                                          child: Text(
                                            widget.place.website,
                                            style: GoogleFonts.rubik(
                                                fontSize: 14,
                                                color: const Color(0xFF135185)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 16,
                                      color: Color(0xff0B799E),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      widget.place.contact,
                                      style: GoogleFonts.rubik(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Color(0xffFF9680),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: _showLocationModal,
                        child: SizedBox(
                          width: 240,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              widget.place.address,
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ReviewsScreen(
                              locationID: widget.place.id,
                            ),
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: RatingBar(
                          rating: double.tryParse(widget.place.rating) ?? 0.0,
                          reviewCount: 3200,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildIconSection(
                        'Open',
                        '${TimeOfDay(hour: widget.place.opentime.toInt(), minute: ((widget.place.opentime % 1) * 60).toInt()).format(context)} - ${TimeOfDay(hour: widget.place.closetime.toInt(), minute: ((widget.place.closetime % 1) * 60).toInt()).format(context)}',
                      ),
                      buildIconSection('Distance', '3 KM'),
                      buildIconSection('Price', '${widget.place.price} KRW'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.place.history,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const ChatbotFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
