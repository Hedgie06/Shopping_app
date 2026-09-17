import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService _productService = ProductService();
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  List<Product> products = [];
  bool isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool _isSearching = false;
  int _skip = 0;
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    loadProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore && _hasMore && !_isSearching) {
        loadProducts(isLoadMore: true);
      }
    }
  }

  Future<void> loadProducts({bool isLoadMore = false}) async {
    if (isLoadMore) {
      setState(() => _isLoadingMore = true);
    } else {
      setState(() => isLoading = true);
    }

    try {
      final result = await _productService.fetchProducts(
        skip: _skip,
        limit: _limit,
      );

      setState(() {
        if (result.length < _limit) {
          _hasMore = false;
        }
        _skip += _limit;

        if (isLoadMore) {
          products.addAll(result);
        } else {
          products = result;
        }

        isLoading = false;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        _isLoadingMore = false;
      });
    }
    // TODO: Reenable network connectivity listener after resolving emulator connectivity detection issue
    // if (mounted) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       backgroundColor: Colors.white,
    //       title: const Row(
    //         children: [
    //           Icon(Icons.error_outline, color: Colors.redAccent),
    //           SizedBox(width: 8),
    //           Text('Request Failed'),
    //         ],
    //       ),
    //       content: const Text(
    //         'Network request failed. Please check your connection and try again.',
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.pop(context),
    //           child: const Text('OK', style: TextStyle(color: Colors.black)),
    //         ),
    //       ],
    //     ),
    //   );
    // }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      _isSearching = false;
      _skip = 0;
      _hasMore = true;
      loadProducts();
      return;
    }

    setState(() {
      _isSearching = true;
      isLoading = true;
    });

    try {
      final results = await _productService.searchProducts(query);

      setState(() {
        products = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        products = [];
        isLoading = false;
      });

      // TODO: Reenable network connectivity listener after resolving emulator connectivity detection issue
      // if (mounted) {
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       backgroundColor: Colors.white,
      //       title: const Row(
      //         children: [
      //           Icon(Icons.error_outline, color: Colors.redAccent),
      //           SizedBox(width: 8),
      //           Text('Request Failed'),
      //         ],
      //       ),
      //       content: const Text(
      //         'Network request failed. Please check your connection and try again.',
      //       ),
      //       actions: [
      //         TextButton(
      //           onPressed: () => Navigator.pop(context),
      //           child: const Text('OK', style: TextStyle(color: Colors.black)),
      //         ),
      //       ],
      //     ),
      //   );
      // }
    }
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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: searchController,
                    onChanged: (query) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();

                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        searchProducts(query.trim());
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search products..',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: products.isEmpty && !isLoading
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No products found.',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                childAspectRatio: 0.6,
                              ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(product: product);
                          },
                        ),
                ),
                if (_isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(color: Colors.black),
                  ),
              ],
            ),
      backgroundColor: Colors.grey[200],
    );
  }
}
