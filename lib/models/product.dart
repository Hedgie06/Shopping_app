class Product {
  final int id;
  final double price;
  final String title;

  Product({
    required this.id,
    required this.price,
    required this.title,
  });

   factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'], 
      price: (json['price'] as num).toDouble(),
      title: json['title'],
    );
   }
}