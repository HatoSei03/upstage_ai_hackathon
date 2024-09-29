import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:juju/model/places.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

void getAllPlaceFood(String collection) {
  CollectionReference placeCollection =
      FirebaseFirestore.instance.collection(collection);

  placeCollection.get().then((QuerySnapshot snapshot) {
    for (var documentSnapshot in snapshot.docs) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        List<String> imgList = [];
        if (data['img'] != null) {
          imgList = List<String>.from(data['img']);
        }

        List<String> tagList = [];
        if (data['tag'] != null) {
          tagList = List<String>.from(data['tag']);
        }

        Place tmpPlace = Place(
          id: data['id'] ?? const Uuid().v4(),
          name: data['name'] ?? 'Null',
          address: data['address'] ?? 'Null',
          rating: data['rating'] ?? '0',
          img: imgList,
          tag: tagList,
          price: data['price'] ?? 0,
          history: data['history'] ?? '',
          closetime: (data['closetime'] is num)
              ? (data['closetime'] > 24
                  ? data['closetime'] / 100
                  : data['closetime'])
              : 24,
          opentime: (data['opentime'] is num)
              ? (data['opentime'] > 24
                  ? data['opentime'] / 100
                  : data['opentime'])
              : 0,
          website: data['web'] ?? 'N/A',
          contact: data['contact'] ?? 'N/A',
          long: data['long'] ?? 0,
          lat: data['lat'] ?? 0,
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
    }
    print("Data retrieval from '$collection' completed successfully.");
  }).catchError((error) {
    print("Failed to retrieve data from '$collection': $error");
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
