// cart_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';
import '../model/item.dart'; // Import the Item class
import 'item_details.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: GoogleFonts.notoSerif(
            fontSize: 24,
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Consumer<CartModel>(
        builder: (context, cartModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // List view of cart items
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: cartModel.cartItems.isEmpty
                      ? Center(
                          child: Text(
                            'Your cart is empty.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: cartModel.cartItems.length,
                          itemBuilder: (context, index) {
                            Item item = cartModel.cartItems[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ListTile(
                                  leading: Image.network(
                                    item.img,
                                    height: 36,
                                    width: 36,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    item.name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Price: \$${item.price}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Category: ${item.category}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Stock: ${item.stock}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.cancel),
                                    onPressed: () =>
                                        cartModel.removeItemFromCart(index),
                                  ),
                                  onTap: () {
                                    // Navigate to ProductDetailPage
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                          item: item,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),

              // Total amount + Pay now
              if (cartModel.cartItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(color: Colors.green[200]),
                            ),

                            const SizedBox(height: 8),
                            // Total price
                            Text(
                              '\$${cartModel.calculateTotal()}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // Pay now button
                        ElevatedButton(
                          onPressed: () {
                            // Implement payment functionality here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Payment functionality not implemented.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.green,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Row(
                            children: const [
                              Text(
                                'Pay Now',
                                style: TextStyle(color: Colors.green),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
