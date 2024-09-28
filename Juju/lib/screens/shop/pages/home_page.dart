// home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../components/grocery_item_tile.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';
import 'notification_screen.dart';
import '../model/item.dart';
import 'package:juju/util/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'all';
  Color selectedColor = const Color(0xffEF7168);
  Color textColor = const Color(0xff6A778B);
  bool isAscending = true;

  void selectCategory() {
    setState(() {});
  }

  List<String> adsQuotes = [
    'Special Offer: 20% Off All Local Souvenirs!',
    'Get 10% Off on All Food Items!',
    'Buy 2 Get 1 Free on All Items!',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
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
<<<<<<< HEAD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Categories",
                      style: GoogleFonts.rubik(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
=======
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Expanded(
                  child: Text(
                    "Vouchers",
                    style: GoogleFonts.notoSerif(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
>>>>>>> 9951e40aa2d08d0173b1699641fa6b10b7eed9e3
                    ),
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 120.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: adsQuotes.map((str) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: AdvertisementBanner(str),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Categories",
                        style: GoogleFonts.notoSerif(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAscending = !isAscending;
                        });
                      },
                      child: Chip(
                        label: Text(
                          isAscending ? 'Price ↑' : 'Price ↓',
                          style: GoogleFonts.montserrat(
                            color: textColor,
                            fontSize: 16.0,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: const Color(0xffD6D6D6),
                            width: 1,
                          ),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryTile('All'),
                      _buildCategoryTile('Food'),
                      _buildCategoryTile('Souvenir'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Items Grid
              Expanded(
                child: Consumer<CartModel>(
                  builder: (context, cartModel, child) {
                    List<Item> displayedItems = selectedCategory == 'all'
                        ? cartModel.shopItems
                        : cartModel.shopItems
                            .where((item) =>
                                item.category.toLowerCase() ==
                                selectedCategory.toLowerCase())
                            .toList();

                    displayedItems.sort((a, b) {
                      double discountedPriceA = double.tryParse(a.price)! *
                          double.tryParse(a.discount)! /
                          100;
                      double discountedPriceB = double.tryParse(b.price)! *
                          double.tryParse(b.discount)! /
                          100;
                      if (isAscending) {
                        return discountedPriceA.compareTo(discountedPriceB);
                      } else {
                        return discountedPriceB.compareTo(discountedPriceA);
                      }
                    });

                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: displayedItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
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
              const SizedBox(height: 16),
            ],
          ),
          // Uncomment if AdvertisementBanner is needed elsewhere
          // Consumer<CartModel>(
          //   builder: (context, cartModel, child) {
          //     return Align(
          //       alignment: Alignment.bottomCenter,
          //       child: Padding(
          //         padding: const EdgeInsets.all(24.0),
          //         child: AdvertisementBanner(),
          //       ),
          //     );
          //   },
          // ),
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

  Widget _buildCategoryTile(String title) {
    bool isSelected = selectedCategory.toLowerCase() == title.toLowerCase();
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title.toLowerCase();
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ChoiceChip(
          showCheckmark: false,
<<<<<<< HEAD
          label: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.rubik(
                  color: isSelected ? Colors.white : textColor,
                  fontSize: 16.0,
                ),
              ),
            ],
=======
          label: Text(
            title,
            style: GoogleFonts.montserrat(
              color: isSelected ? Colors.white : textColor,
              fontSize: 16.0,
            ),
>>>>>>> 9951e40aa2d08d0173b1699641fa6b10b7eed9e3
          ),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              selectedCategory = title.toLowerCase();
            });
          },
          selectedColor: selectedColor,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: isSelected ? selectedColor : const Color(0xffD6D6D6),
              width: 1,
            ),
          ),
          elevation: isSelected ? 3 : 0,
        ),
      ),
    );
  }
}

class AdvertisementBanner extends StatelessWidget {
  final String text;
  const AdvertisementBanner(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.rubik(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.orange[900],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
