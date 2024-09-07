import 'dart:convert';

import 'package:be_glamourous/models/product_data.dart';
import 'package:be_glamourous/services/api_url.dart';
import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ProductRecommendationPage extends StatefulWidget {
  final int userId; // Add userId to identify the current user
  final Map<String, double> scores;
  final List<String> titles;

  const ProductRecommendationPage({
    super.key,
    required this.userId, // Pass userId
    required this.scores,
    required this.titles,
  });

  @override
  State<ProductRecommendationPage> createState() =>
      _ProductRecommendationPageState();
}

class _ProductRecommendationPageState extends State<ProductRecommendationPage> {
  List<Product> filteredProducts = [];
  bool isLoading = true;
  final String apiURL = apiUrl();

  @override
  void initState() {
    super.initState();
    _fetchRecommendedProducts(); // Fetch recommended products on init
  }

  Future<void> _fetchRecommendedProducts() async {
    try {
      // Prepare the concerns based on scores (only conditions with scores < 50)
      String concerns =
          widget.titles.where((title) => widget.scores[title]! < 50).join(',');

      // Make the request to the /api/products/matching endpoint
      final productResponse = await http.get(Uri.parse(
          '$apiURL/api/products/matching?userId=${widget.userId}&concerns=$concerns'));

      if (productResponse.statusCode == 200) {
        final List<dynamic> productData = jsonDecode(productResponse.body);

        setState(() {
          filteredProducts =
              productData.map((json) => Product.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        Logger().e(
            'Failed to fetch products. Status code: ${productResponse.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      Logger().e("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(fontFamily: 'Jura'),
      child: Container(
        decoration: DecorationHelper.backgroundDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Product Recommendations',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.black26,
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : filteredProducts.isEmpty
                  ? const Center(child: Text("No products found"))
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        String sideEffectsText = product.sideEffects.isNotEmpty
                            ? 'Side Effects: ${product.sideEffects.join(', ')}'
                            : 'No reported side effects';
                        return ListTile(
                          title: Text(
                            product.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.description,
                                style: const TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                sideEffectsText,
                                style: const TextStyle(
                                  color: Color.fromARGB(197, 206, 70, 61),
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                            product.brand,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
