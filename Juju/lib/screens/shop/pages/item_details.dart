import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

class ProductDetailPage extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final List<String> imagePaths;
  final String description;
  final List<String> suggestions; // Gợi ý sản phẩm tương tự

  ProductDetailPage({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePaths,
    required this.description,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName, style: GoogleFonts.notoSerif()),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scroll hình ảnh ngang
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(imagePaths[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: GoogleFonts.notoSerif(fontSize: 16),
              ),
            ),
            // Thêm thông tin chung
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Price: \$$itemPrice',
                style: GoogleFonts.notoSerif(fontSize: 16),
              ),
            ),
            // Thêm nút thêm vào giỏ hàng
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CartModel>(context, listen: false)
                      .addItemToCartByName(itemName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$itemName added to cart'),
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
            // Gợi ý sản phẩm tương tự
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to another ProductDetailPage if needed
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              suggestions[index],
                              textAlign: TextAlign.center,
                            ),
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
