import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService _productService = ProductService();

  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final result = await _productService.fetchProducts();

    setState(() {
      products = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Text(
              'Shopping App',
              style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Colors.white,
              ),
            ),
            Text(
              'Shopping App',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return ListTile(
                  title: Text(product.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.brand),
                      Text(product.category),
                      Text('\$${product.price}'),
                      Text('${product.discountPercentage}%'), 
                      Text('${product.rating}'),
                      Text(product.shippingInformation),
                    ],
                  ),
                );
                /*return ListTile(
                  title: Text(product.title),
                  subtitle: Text(
                    '\$${product.price} ${product.category}'
                    ),
                );*/
              },
            ),
      backgroundColor: Colors.white,
    );
  }
}
