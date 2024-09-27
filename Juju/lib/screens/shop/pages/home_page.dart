// home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';
import 'notification_screen.dart';
import '../model/item.dart'; // Import the Item class

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search products...",
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Navigate to the NotificationScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Categories Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Categories",
                  style: GoogleFonts.notoSerif(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Horizontal List of Categories
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CategoryTile(title: 'All'),
                    CategoryTile(title: 'Food'),
                    CategoryTile(title: 'Souvenir'),
                    // Add more categories as needed
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Grid of Products
              Expanded(
                child: Consumer<CartModel>(
                  builder: (context, cartModel, child) {
                    // Filter items based on selectedCategory
                    List<Item> displayedItems = selectedCategory == 'All'
                        ? cartModel.shopItems
                        : cartModel.shopItems
                            .where((item) => item.category == selectedCategory)
                            .toList();

                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: displayedItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 columns
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1 / 1.6,
                      ),
                      itemBuilder: (context, index) {
                        var item = displayedItems[index];
                        return GroceryItemTile(
                          item: item,
                          onPressed: () {
                            Provider.of<CartModel>(context, listen: false)
                                .addItemToCart(
                                    cartModel.shopItems.indexOf(item));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item.name} added to cart'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              // Additional space for AdvertisementBanner
              const SizedBox(height: 16),
            ],
          ),
          // Positioned AdvertisementBanner at the bottom
          Consumer<CartModel>(
            builder: (context, cartModel, child) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: AdvertisementBanner(),
                ),
              );
            },
          ),
        ],
      ),
      // Floating Cart Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          );
        },
        backgroundColor: Colors.green,
        child: Stack(
          children: [
            const Icon(Icons.shopping_cart),
            Positioned(
              right: 0,
              child: Consumer<CartModel>(
                builder: (context, cart, child) {
                  return cart.cartItems.isNotEmpty
                      ? CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            cart.cartItems.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String title;

  const CategoryTile({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    bool isSelected = false; // You can add logic to handle selection

    return GestureDetector(
      onTap: () {
        // Update selected category
        // Implement state management to handle category selection
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class AdvertisementBanner extends StatelessWidget {
  const AdvertisementBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'Special Offer: 20% Off All Local Souvenirs!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange[900],
          ),
        ),
      ),
    );
  }
}
