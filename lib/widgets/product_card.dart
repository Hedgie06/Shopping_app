import 'package:flutter/material.dart';
import 'package:shopping_app1/views/product_detail_screen.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailScreen(productID: product.id, product: product),
          ),
        ),
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.thumbnail,
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 40);
                  },
                ),
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
              Text(
                product.brand,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                product.category,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.discountedPrice.toStringAsFixed(2)}',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
            ],
          )
        ),
      ),
    );
  }
}
