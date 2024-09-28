// cart_model.dart
import 'package:flutter/material.dart';
import 'item.dart'; 

class CartModel extends ChangeNotifier {
  final List<Item> _shopItems = itemList;

  final List<Item> _cartItems = [];

  List<Item> get cartItems => _cartItems;
  List<Item> get shopItems => _shopItems;

  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void addItemToCartByName(String itemName) {
    try {
      var item = _shopItems.firstWhere((element) => element.name == itemName);
      _cartItems.add(item);
      notifyListeners();
    } catch (e) {
      print('Item with name $itemName not found.');
    }
  }

  void removeItemFromCart(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

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
