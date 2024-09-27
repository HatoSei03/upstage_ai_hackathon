import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';
  List<String> searchHistory = [];
  List filteredItems = [];

  @override
  Widget build(BuildContext context) {
    var shopItems = Provider.of<CartModel>(context).shopItems;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
              filteredItems = shopItems.where((item) => item[0].toLowerCase().contains(searchQuery.toLowerCase())).toList();
            });
          },
        ),
      ),
      body: Column(
        children: [
          // Lịch sử tìm kiếm
          if (searchHistory.isNotEmpty) ...[
            Text('Search History'),
            for (var history in searchHistory)
              ListTile(
                title: Text(history),
                onTap: () {
                  setState(() {
                    searchQuery = history;
                    filteredItems = shopItems.where((item) => item[0].toLowerCase().contains(searchQuery.toLowerCase())).toList();
                  });
                },
              ),
          ],
          // Kết quả tìm kiếm
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                var item = filteredItems[index];
                return ListTile(
                  title: Text(item[0]),
                  subtitle: Text('\$${item[1]}'),
                  leading: Image.asset(item[4]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
