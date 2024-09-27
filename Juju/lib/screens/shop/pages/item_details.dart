// item_details.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';
import '../model/item.dart'; // Import the Item class

class ProductDetailPage extends StatelessWidget {
  final Item item;

  const ProductDetailPage({
    required this.item,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Assuming you have a list of suggestions, you can generate them based on category or other logic
    List<String> suggestions = []; // Populate as needed

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name, style: GoogleFonts.notoSerif()),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    1, // Assuming single image, adjust if multiple images are available
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      item.img,
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                item.description,
                style: GoogleFonts.notoSerif(fontSize: 16),
              ),
            ),
            // General Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'General Information:',
                style: GoogleFonts.notoSerif(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Price: \$${item.price}',
                style: GoogleFonts.notoSerif(fontSize: 16),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Seller: ${item.seller}',
                style: GoogleFonts.notoSerif(fontSize: 16),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Rating: ${item.rating} ⭐',
                style: GoogleFonts.notoSerif(fontSize: 16),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Stock: ${item.stock}',
                style: GoogleFonts.notoSerif(fontSize: 16),
              ),
            ),
            // Add more general info as needed

            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CartModel>(context, listen: false)
                      .addItemToCartByName(item.name);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.name} added to cart'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            // Suggested Products
            if (suggestions.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'You may also like:',
                  style: GoogleFonts.notoSerif(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    // Fetch the suggested item based on the name
                    var suggestedItem =
                        Provider.of<CartModel>(context, listen: false)
                            .shopItems
                            .firstWhere(
                                (element) => element.name == suggestions[index],
                                orElse: () => Item(
                                    name: 'Item not found',
                                    img: '',
                                    price: '0.0',
                                    seller: '',
                                    rating: '0.0',
                                    stock: '0',
                                    description: '',
                                    id: '',
                                    category: '',
                                    discount: '0.0',
                                    sold: '0',
                                    origin: ''));
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the ProductDetailPage for the suggested item
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                item: suggestedItem,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                suggestedItem.img,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                suggestedItem.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
