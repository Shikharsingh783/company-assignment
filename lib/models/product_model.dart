class ProductModel {
  final String name;
  final String stocks;
  final double price;
  final String? imagePath;

  ProductModel({
    this.imagePath,
    required this.name,
    required this.price,
    required this.stocks,
  });
}
