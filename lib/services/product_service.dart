import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products?limit=20&skip=0'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['products'] as List)
          .map((json) => Product.fromJson(json))
          .toList();
    }

    throw Exception('Failed to load products');
  }

  Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products/search?q=$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['products'] as List)
          .map((json) => Product.fromJson(json))
          .toList();
    }

    throw Exception('Failed to search products');
  }
}
