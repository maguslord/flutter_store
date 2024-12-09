class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String supplierName;
  final String categoryName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.supplierName,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'],
      name: json['product_name'],
      description: json['product_description'],
      price: json['price'].toDouble(),
      imageUrl: json['product_image'],
      supplierName: json['supplier_name'],
      categoryName: json['category_name'],
    );
  }
}
