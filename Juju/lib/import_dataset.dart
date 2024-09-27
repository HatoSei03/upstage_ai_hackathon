// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  String jsonString = await rootBundle.loadString('assets/data.json');
  List<dynamic> jsonData = json.decode(jsonString);

  CollectionReference placesCollection =
      FirebaseFirestore.instance.collection('food');

  for (var item in jsonData) {
    item.remove('_id');

    if (!item.containsKey('id')) {
      item['id'] = const Uuid().v4();
    }

    if (item.containsKey('images')) {
      item['img'] = item['images'];
      item.remove('images');
    }

    if (item.containsKey('tags')) {
      item['tag'] = item['tags'];
      item.remove('tags');
    }

    if (item.containsKey('price')) {
      item['price'] = num.tryParse(item['price'].toString()) ?? 0;
    }

    if (item.containsKey('rating')) {
      item['rating'] = item['rating'].toString();
    }

    if (item.containsKey('opentime')) {
      item['opentime'] = num.tryParse(item['opentime'].toString()) ?? 0;
    }
    if (item.containsKey('closetime')) {
      item['closetime'] = num.tryParse(item['closetime'].toString()) ?? 24;
    }

    await placesCollection
        .doc(item['id'])
        .set(item)
        .then((value) => print("Place Added: ${item['name']}"))
        .catchError(
            (error) => print("Failed to add place ${item['name']}: $error"));
  }

  print("Data import completed successfully.");
}
