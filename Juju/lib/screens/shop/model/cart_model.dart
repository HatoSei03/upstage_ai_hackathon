// cart_model.dart
import 'package:flutter/material.dart';
import 'item.dart'; // Make sure to import the Item class file

class CartModel extends ChangeNotifier {
  // Initialize the shop items with the predefined itemList
  final List<Item> _shopItems = itemList;

  // Cart items as a list of Item objects
  final List<Item> _cartItems = [];

  // Getters
  List<Item> get cartItems => _cartItems;
  List<Item> get shopItems => _shopItems;

  // Add item to cart by index
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // Add item to cart by name
  void addItemToCartByName(String itemName) {
    try {
      var item = _shopItems.firstWhere((element) => element.name == itemName);
      _cartItems.add(item);
      notifyListeners();
    } catch (e) {
      // Handle the case where the item is not found
      print('Item with name $itemName not found.');
    }
  }

  // Remove item from cart by index
  void removeItemFromCart(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  // Calculate total price considering discounts
  String calculateTotal() {
    double totalPrice = 0;
    for (var item in _cartItems) {
      double price = double.tryParse(item.price) ?? 0.0;
      double discount = double.tryParse(item.discount) ?? 0.0;
      double finalPrice = price * (1 - discount / 100);
      totalPrice += finalPrice;
    }
    return totalPrice.toStringAsFixed(2);
  }
}
