import 'package:flutter/material.dart';
import 'package:shopping_app1/models/product.dart';
import '../services/product_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({
    super.key,
    required this.product,
    required int productID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [Text(product.title), Text(product.brand)]),
      ),
    );
    throw UnimplementedError();
  }
}
