import 'dart:math';

import 'package:be_glamourous/Screens/skin_analyzer_screen/product_recommendation_page.dart';
import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:be_glamourous/services/skin_analyze_service.dart';
import 'package:be_glamourous/themes/decoration_helper.dart';
import 'package:be_glamourous/utils/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AnalyzeResultPage extends StatefulWidget {
  final Map<String, dynamic> result;
  const AnalyzeResultPage({
    super.key,
    required this.result,
  });

  @override
  State<AnalyzeResultPage> createState() => _AnalyzeResultPageState();
}

double calculateHealthScore(Map<String, double> probabilityScores) {
  // Define the weights for each condition
  Map<String, double> weights = {
    'acne': 0.5,
    'bags': 0.3,
    'redness': 0.2,
  };

  // Use a logistic function to scale probabilities
  double logistic(double x) {
    return 1 / (1 + exp(-x));
  }

  // Start with a perfect score of 1.0 (100% health)
  double healthScore = 1.0;

  // Subtract the weighted adjusted probability of each condition from the health score
  probabilityScores.forEach((condition, probability) {
    double weight = weights[condition] ?? 0.0; // Default to 0 if not specified
    // Adjust probability using a logistic function centered around 0.5
    double adjustedProbability = logistic((probability - 0.5) * 10);
    healthScore -= adjustedProbability * weight;
  });

  return (healthScore * 100)
      .clamp(0.0, 100.0); // Return as a percentage, clamped between 0 and 100
}

class _AnalyzeResultPageState extends State<AnalyzeResultPage> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  late List<String> titles; // Titles for the scores
  late List<double> scores; // Actual scores
  late double overallHealthScore;
  final List<Color> progressBarColors = const [
    Color.fromARGB(255, 159, 192, 25),
    Color(0xffDB2B20),
    Color(0xff12419D),
  ];

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> qualityScores =
        Map<String, dynamic>.from(widget.result['skin_quality_scores']);
    final Map<String, dynamic> probabilityScores =
        Map<String, dynamic>.from(widget.result['probability_scores']);

    titles = qualityScores.keys.toList();
    scores = qualityScores.values.map<double>((v) => v.toDouble()).toList();

    // Calculate and store the overall health score separately
    overallHealthScore = calculateHealthScore(
        probabilityScores.map((key, value) => MapEntry(key, value.toDouble())));

    // Save scores to the database using the service
    _saveScores();
  }

  Future<void> _navigateToProductRecommendationPage() async {
    // Retrieve the userID from SecureStorage
    String? userID = await secureStorage.read(key: 'userID');

    if (userID != null) {
      // Prepare the data to pass
      Map<String, double> scoresMap = Map.fromIterables(titles, scores);

      // Navigate to the ProductRecommendationPage and pass userId
      if (mounted) {
        Customnavigation.nextPage2(
          context,
          ProductRecommendationPage(
            scores: scoresMap,
            titles: titles,
            userId: int.parse(userID), // Pass userID as an int
          ),
        );
      }
    } else {
      Logger().e('User ID not found in session storage');
      // Handle the case where userID is not found
    }
  }

  Future<void> _saveScores() async {
    String? userID = await secureStorage.read(key: 'userID');

    if (userID != null) {
      final SkinAnalyzeService analyzeService = SkinAnalyzeService();

      // Call the service method to save scores
      await analyzeService.saveScoresToDatabase(
        userID: int.parse(userID),
        acneScore: scores[titles.indexOf('acne')],
        bagsScore: scores[titles.indexOf('bags')],
        rednessScore: scores[titles.indexOf('redness')],
        overallHealthScore: overallHealthScore,
      );
    } else {
      Logger().e('User ID not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: DecorationHelper.backgroundDecoration(),
        child: Theme(
          data: ThemeData(
            fontFamily: 'Jura',
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  'Your Analyze Results',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Center(
                      child: CircularPercentIndicator(
                        radius: 80,
                        lineWidth: 13,
                        animation: true,
                        percent: overallHealthScore / 100,
                        center: Text(
                          "${overallHealthScore.toStringAsFixed(2)}%",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey.shade800,
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(155, 0, 0, 0),
                      thickness: 2,
                    ),
                    ...titles.map((title) {
                      int index = titles.indexOf(title);
                      return ListTile(
                        title: Text(
                          title == 'acne'
                              ? "Acne"
                              : title == 'bags'
                                  ? "Under-eye Bags"
                                  : "Redness",
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: LinearPercentIndicator(
                            lineHeight: 20,
                            percent: scores[index] / 100,
                            backgroundColor: Colors.grey.shade800,
                            progressColor: progressBarColors[index],
                          ),
                        ),
                      );
                    }),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Higher scores indicate better overall skin health, reflecting fewer skin concerns.',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Jura',
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: _navigateToProductRecommendationPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .secondary, // Background color
                        ),
                        child: const Text(
                          'Proceed to Next Step',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
