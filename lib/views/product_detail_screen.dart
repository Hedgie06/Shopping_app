import 'package:flutter/material.dart';
import 'package:shopping_app1/models/product.dart';
import '../services/product_service.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp, color: Colors.white),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: product.images.isNotEmpty
                  ? PageView.builder(
                      itemCount: product.images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          product.images[index],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              size: 40,
                            );
                          },
                        );
                      },
                    )
                  : const Icon(Icons.image_not_supported, size: 40),
            ),
            Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product.brand),
                Row(
                  children: [
                    Icon(Icons.star, size: 15, color: Colors.orangeAccent),
                    Text(
                      '${product.rating}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '\$${product.discountedPrice.toStringAsFixed(2)}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${product.discountPercentage}% OFF',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            Row(
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    size: 14,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      product.shippingInformation,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            Text(
              product.description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
