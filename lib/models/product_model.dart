class Product {
  final String name;
  final String stocks;
  final double price;
  final String? imagePath;

  Product({
    this.imagePath,
    required this.name,
    required this.price,
    required this.stocks,
  });

  // Convert a ProductModel object into a Map object for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'stocks': stocks,
      'price': price,
      'imagePath': imagePath,
    };
  }

  // Create a ProductModel object from a Map object
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      stocks: map['stocks'] ?? '',
      price: (map['price'] as num).toDouble(),
      imagePath: map['imagePath'],
    );
  }
}
