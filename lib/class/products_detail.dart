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
      id: json['product_id'] is int 
          ? json['product_id'] 
          : int.parse(json['product_id'].toString()),
      name: json['product_name'].toString(),
      description: json['product_description'].toString(),
      price: json['price'] is double 
          ? json['price'] 
          : double.parse(json['price'].toString()),
      imageUrl: json['product_image'].toString(),
      supplierName: json['supplier_name'].toString(),
      categoryName: json['category_name'].toString(),
    );
  }
}