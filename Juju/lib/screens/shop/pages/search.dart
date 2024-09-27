import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';
import 'item_details.dart'; // Import the ProductDetailPage

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
              filteredItems = shopItems
                  .where((item) => item[0]
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .toList();
              if (value.isNotEmpty && !searchHistory.contains(value)) {
                searchHistory.add(value);
              }
            });
          },
          onSubmitted: (value) {
            if (value.isNotEmpty && !searchHistory.contains(value)) {
              setState(() {
                searchHistory.add(value);
              });
            }
          },
        ),
      ),
      body: Column(
        children: [
          // Lịch sử tìm kiếm
          if (searchHistory.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Search History',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  var history = searchHistory[index];
                  return ListTile(
                    title: Text(history),
                    leading: Icon(Icons.history),
                    onTap: () {
                      setState(() {
                        searchQuery = history;
                        filteredItems = shopItems
                            .where((item) => item[0]
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                            .toList();
                      });
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          searchHistory.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
          // Kết quả tìm kiếm
          if (searchQuery.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Search Results',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        'No results found.',
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        var item = filteredItems[index];
                        return ListTile(
                          title: Text(item[0]),
                          subtitle: Text('\$${item[1]}'),
                          leading: Image.asset(item[4]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  itemName: item[0],
                                  itemPrice: item[1],
                                  imagePaths: [item[4]],
                                  description: item[5],
                                  suggestions: [], // Add suggestions as needed
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ],
      ),
    );
  }
}
