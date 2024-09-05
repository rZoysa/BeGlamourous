import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:be_glamourous/models/product_data.dart';
import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:be_glamourous/utils/sample_product_data.dart';
import 'package:flutter/material.dart';

class ProductRecommendationPage extends StatefulWidget {
  final Map<String, double> scores;
  final List<String> titles;
  const ProductRecommendationPage({
    super.key,
    required this.scores,
    required this.titles,
  });

  @override
  State<ProductRecommendationPage> createState() =>
      _ProductRecommendationPageState();
}

class _ProductRecommendationPageState extends State<ProductRecommendationPage> {
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filterProducts();
  }

  void filterProducts() {
    filteredProducts = products.where((product) {
      return widget.titles.any((title) =>
          product.suitableSkinType.contains(title.toLowerCase()) &&
          widget.scores[title]! >= 50); // Assuming score > 50 is significant
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: DecorationHelper.backgroundDecoration(),
        child: Column(
          children: [
            const CustomAppBar(),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredProducts[index].name),
                    subtitle: Text(filteredProducts[index].description),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
