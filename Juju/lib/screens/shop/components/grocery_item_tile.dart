import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';
import '../pages/item_details.dart'; // Import the ProductDetailPage

class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final String itemWeight;
  final String itemCount;
  final String description;
  final String generalInfo;
  final double rating;
  final int sold;

  void Function()? onPressed;

  GroceryItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.itemWeight,
    required this.itemCount,
    required this.description,
    required this.generalInfo,
    required this.rating,
    required this.sold,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              itemName: itemName,
              itemPrice: itemPrice,
              imagePaths: [imagePath], // Convert single imagePath to list
              description: description,
              suggestions: [], // Provide suggestions as needed
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ảnh sản phẩm
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Image.asset(
                  imagePath,
                  height: 64,
                ),
              ),
              // Tên sản phẩm
              Text(
                itemName,
                style: const TextStyle(fontSize: 16),
              ),
              // Giá, số lượt bán, và đánh giá sao
              Text(
                '\$$itemPrice - Sold: $sold',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  );
                }),
              ),
              // Nút thêm vào giỏ hàng
              MaterialButton(
                onPressed: onPressed,
                color: Colors.green,
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
