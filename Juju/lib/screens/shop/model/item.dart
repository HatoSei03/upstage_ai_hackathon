class Item {
  final String id;
  final String name;
  final String category;
  final String seller;
  final String origin;
  final String description;
  final String sold;
  final String stock;
  final String price;
  final String img;
  final String discount;
  final String rating;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.seller,
    required this.origin,
    required this.description,
    required this.sold,
    required this.stock,
    required this.price,
    required this.img,
    required this.discount,
    required this.rating,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      seller: json['seller'],
      origin: json['origin'],
      description: json['description'],
      sold: json['sold'],
      stock: json['stock'],
      price: json['price'],
      img: json['img'],
      discount: json['discount'],
      rating: json['rating'],
    );
  }
}
