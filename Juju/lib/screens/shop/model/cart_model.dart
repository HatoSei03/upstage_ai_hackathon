import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // List of items on sale
  final List _shopItems = const [
    // [itemName, itemPrice, itemWeight, itemCount, imagePath, description, generalInfo]
    [
      "Avocado",
      "4.00",
      "1kg",
      "10",
      "lib/images/avocado.png",
      "Fresh avocados from local farms.",
      "Rich in healthy fats and vitamins."
    ],
    [
      "Banana",
      "2.50",
      "1kg",
      "20",
      "lib/images/banana.png",
      "Sweet and ripe bananas.",
      "High in potassium and fiber."
    ],
    [
      "Chicken",
      "12.80",
      "2kg",
      "15",
      "lib/images/chicken.png",
      "Organic free-range chicken.",
      "High in protein and low in fat."
    ],
    [
      "Water",
      "1.00",
      "1L",
      "50",
      "lib/images/water.png",
      "Pure spring water.",
      "Refreshing and hydrating."
    ],
    [
      "Tomato",
      "3.00",
      "1kg",
      "25",
      "lib/images/tomato.png",
      "Juicy red tomatoes.",
      "Rich in antioxidants."
    ],
    [
      "Bread",
      "2.20",
      "500g",
      "30",
      "lib/images/bread.png",
      "Whole grain bread loaf.",
      "High in fiber and nutrients."
    ],
    [
      "Milk",
      "1.50",
      "1L",
      "40",
      "lib/images/milk.png",
      "Organic whole milk.",
      "Rich in calcium and vitamins."
    ],
    [
      "Eggs",
      "2.80",
      "12pcs",
      "35",
      "lib/images/eggs.png",
      "Free-range eggs.",
      "High-quality protein source."
    ],
    [
      "Cheese",
      "5.00",
      "200g",
      "18",
      "lib/images/cheese.png",
      "Aged cheddar cheese.",
      "Strong flavor and rich texture."
    ],
    [
      "Orange",
      "3.50",
      "1kg",
      "22",
      "lib/images/orange.png",
      "Citrus sweet oranges.",
      "Packed with vitamin C."
    ],
    [
      "Carrot",
      "1.80",
      "1kg",
      "28",
      "lib/images/carrot.png",
      "Crunchy fresh carrots.",
      "Good for vision and health."
    ],
    [
      "Potato",
      "2.00",
      "2kg",
      "24",
      "lib/images/potato.png",
      "Organic potatoes.",
      "Versatile and nutritious."
    ],
    [
      "Spinach",
      "2.50",
      "500g",
      "20",
      "lib/images/spinach.png",
      "Fresh spinach leaves.",
      "Rich in iron and vitamins."
    ],
    [
      "Beef",
      "15.00",
      "1kg",
      "12",
      "lib/images/beef.png",
      "Grass-fed beef cuts.",
      "High in protein and iron."
    ],
    [
      "Yogurt",
      "1.20",
      "500g",
      "30",
      "lib/images/yogurt.png",
      "Natural plain yogurt.",
      "Probiotics for digestive health."
    ],
    [
      "Broccoli",
      "2.30",
      "1kg",
      "19",
      "lib/images/broccoli.png",
      "Fresh green broccoli.",
      "Rich in vitamins and minerals."
    ],
    [
      "Rice",
      "3.00",
      "5kg",
      "10",
      "lib/images/rice.png",
      "Long grain white rice.",
      "Staple carbohydrate source."
    ],
    [
      "Pasta",
      "2.70",
      "1kg",
      "16",
      "lib/images/pasta.png",
      "Premium durum wheat pasta.",
      "Perfect for various dishes."
    ],
    [
      "Onion",
      "1.50",
      "1kg",
      "26",
      "lib/images/onion.png",
      "Fresh yellow onions.",
      "Essential for cooking flavors."
    ],
    [
      "Garlic",
      "0.80",
      "500g",
      "40",
      "lib/images/garlic.png",
      "Aromatic garlic bulbs.",
      "Enhances flavor and health."
    ],
    [
      "Lettuce",
      "1.20",
      "1 head",
      "23",
      "lib/images/lettuce.png",
      "Crisp green lettuce.",
      "Perfect for salads and sandwiches."
    ],
  ];

  // List of cart items
  final List _cartItems = [];

  List get cartItems => _cartItems;

  List get shopItems => _shopItems;

  get souvenirItems => null;

  // Add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

    void addItemToCartByName(String itemName) {
    var item = shopItems.firstWhere((element) => element[0] == itemName, orElse: () => []);
    if (item.isNotEmpty) {
      cartItems.add(item);
      notifyListeners();
    }
  }

  // Remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // Calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (var item in _cartItems) {
      totalPrice += double.parse(item[1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}
