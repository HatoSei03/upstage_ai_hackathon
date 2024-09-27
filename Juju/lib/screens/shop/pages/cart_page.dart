import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';

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
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // List view of cart items
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: value.cartItems.isEmpty
                      ? Center(
                          child: Text(
                            'Your cart is empty.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: value.cartItems.length,
                          itemBuilder: (context, index) {
                            var item = value.cartItems[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                  leading: Image.asset(
                                    item[4],
                                    height: 36,
                                  ),
                                  title: Text(
                                    item[0],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Price: \$${item[1]}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Weight: ${item[2]}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Available: ${item[3]}',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.cancel),
                                    onPressed: () => Provider.of<CartModel>(
                                            context,
                                            listen: false)
                                        .removeItemFromCart(index),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),

              // Total amount + Pay now
              if (value.cartItems.isNotEmpty)
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
                              '\$${value.calculateTotal()}',
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
