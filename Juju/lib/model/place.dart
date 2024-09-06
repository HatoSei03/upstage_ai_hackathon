// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juju/util/places.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

void getAllPlaceFood(String collection) {
  CollectionReference place = FirebaseFirestore.instance.collection(collection);
  place.get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        Place tmpPlace = Place(
          id: data['id'] ?? const Uuid().v4(),
          name: data['name'],
          address: data['address'],
          rating: data['rating'] ?? '0',
          img: data['image'] ?? '',
          price: data['price'] ?? 0,
          history: data['history'],
          duration: data['duration'] ?? 2,
          closetime: data['closetime'] > 24
              ? data['closetime'] / 100
              : data['closetime'] ?? '24',
          opentime: data['opentime'] > 24
              ? data['opentime'] / 100
              : data['opentime'] ?? '0',
          website: data['web'] ?? 'N/A',
          contact: data['contact'] ?? 'N/A',
        );

        if (collection == 'place') {
          if (places.firstWhereOrNull((element) => element.id == tmpPlace.id) ==
              null) {
            places.add(tmpPlace);
          }
        } else {
          if (food.firstWhereOrNull((element) => element.id == tmpPlace.id) ==
              null) {
            food.add(tmpPlace);
          }
        }
      }
    });
  });
}

class SearchByNameWidget extends StatelessWidget {
  final String searchQuery;
  const SearchByNameWidget(this.searchQuery, {super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('place')
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThan: searchQuery)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Text('Không tìm thấy kết quả');
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            var document = snapshot.data!.docs[index];
            var name = document['name'];
            var image = document['image'];
            return ListTile(
              title: Text(name),
              leading: Image.network(image),
              subtitle: const Text('Lịch sử'),
            );
          },
        );
      },
    );
  }
}
