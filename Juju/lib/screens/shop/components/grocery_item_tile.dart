import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';

class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final String itemWeight;
  final String itemCount;
  final String description;
  final String generalInfo;
  final double rating; // Đánh giá sao
  final int sold; // Số lượt bán
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
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(itemName, style: GoogleFonts.notoSerif(fontSize: 24)),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(imagePath, height: 150),
                    SizedBox(height: 16),
                    Text("Price: \$$itemPrice", style: TextStyle(fontSize: 16)),
                    Text("Weight: $itemWeight", style: TextStyle(fontSize: 16)),
                    Text("Available: $itemCount",
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 16),
                    Text("Description:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(description),
                    SizedBox(height: 8),
                    Text("General Information:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(generalInfo),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: onPressed,
                  child: Text('Add to Cart',
                      style: TextStyle(color: Colors.green)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ],
            );
          },
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
