import 'package:flutter/material.dart';
import 'package:juju/util/const.dart';
import 'package:juju/model/places.dart';
import 'package:juju/widgets/search_card.dart';
import 'package:juju/widgets/trending_place.dart';
import 'package:get/get.dart';
import 'package:juju/widgets/chatbot_float_button.dart';

class Trending extends StatelessWidget {
  final List<Place> source;
  final String name;
  const Trending({super.key, required this.name, required this.source});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Constants.header,
        title: Text(
          name,
          style: TextStyle(
            color: Constants.lightText,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Constants.lightText,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10.0,
        ),
        child: ListView(
          children: <Widget>[
            SearchCard(),
            const SizedBox(height: 10.0),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: source.length,
              itemBuilder: (BuildContext context, int index) {
                return TrendingPlace(place: source[index]);
              },
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
      floatingActionButton: const ChatbotFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
