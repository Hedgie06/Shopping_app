import 'package:shopping_app1/models/review.dart';

class Product {
  final int id;
  final double price;
  final String title;
  final String category;
  final double discountPercentage;
  final double rating;
  final String brand;
  final String shippingInformation;
  final String thumbnail;
  final List<String> images;
  final String description;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.price,
    required this.title,
    required this.category,
    required this.discountPercentage,
    required this.rating,
    required this.brand,
    required this.shippingInformation,
    required this.thumbnail,
    required this.images,
    required this.description,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: (json['price'] as num).toDouble(),
      title: json['title'],
      category: json['category'],
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      brand: json['brand'] ?? '',
      shippingInformation: json['shippingInformation'] ?? '',
      thumbnail: json['thumbnail'] ?? 'image not supported',
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      description: json['description'] ?? 'No description',
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e))
              .toList() ??
          [],
    );
  }
  double get discountedPrice {
    return price - (price * discountPercentage / 100);
  }
}
