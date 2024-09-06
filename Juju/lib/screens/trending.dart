import 'package:flutter/material.dart';
import 'package:juju/util/const.dart';
import 'package:juju/util/places.dart';
import 'package:juju/widgets/search_card.dart';
import 'package:juju/widgets/trending_place.dart';
import 'package:juju/screens/chatbot.dart';

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
            Navigator.pop(context);
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
        backgroundColor: Constants.header,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 2.0,
        child: Icon(
          Icons.question_answer,
          color: Constants.lightText2,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
