import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:be_glamourous/themes/decoration_helper.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: DecorationHelper.backgroundDecoration(),
        child: Column(
          children: [
            const CustomAppBar(),
          ],
        ),
      ),
    );
  }
}
