class CartItem {
  final int id;
  final String title;
  final int quantity;
  final double price;
  final List<String> images;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'price': price,
      'images': images,
    };
  }

  static CartItem fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      quantity: json['quantity'],
      price: json['price'],
      images: List<String>.from(json['images']),
    );
  }
}
