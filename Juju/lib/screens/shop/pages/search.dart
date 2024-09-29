import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';
import 'item_details.dart'; 
import '../model/item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';
  List<String> searchHistory = [];
  List<Item> filteredItems = [];

  @override
  Widget build(BuildContext context) {
    var shopItems = Provider.of<CartModel>(context).shopItems;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
              filteredItems = shopItems
                  .where((item) => item.name
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
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          if (searchHistory.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(8.0),
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
                    leading: const Icon(Icons.history),
                    onTap: () {
                      setState(() {
                        searchQuery = history;
                        filteredItems = shopItems
                            .where((item) => item.name
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()))
                            .toList();
                      });
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
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
          if (searchQuery.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Search Results',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(
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
                          title: Text(item.name),
                          subtitle: Text('\$${item.price}'),
                          leading: Image.network(
                            item.img,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  item: item,
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
