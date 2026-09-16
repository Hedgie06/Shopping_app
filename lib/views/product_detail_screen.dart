import 'package:flutter/material.dart';
import 'package:shopping_app1/models/product.dart';
import 'package:shopping_app1/models/review.dart';
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
            SizedBox(height: 10),

            Text(
              'Reviews',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: product.reviews.length,
                itemBuilder: (context, index) {
                  final review = product.reviews[index];

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.reviewerName,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Row(
                            children: List.generate(
                              5,
                              (starIndex) => Icon(
                                starIndex < review.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 16,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            review.comment,
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: implement the add to cart logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    side: const BorderSide(color: Colors.black, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement buy now logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    throw UnimplementedError();
  }
}
