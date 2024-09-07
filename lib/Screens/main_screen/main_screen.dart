import 'package:be_glamourous/Screens/main_screen/widgets/analyze_results.dart';
import 'package:be_glamourous/Screens/main_screen/widgets/post.dart';
import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:be_glamourous/services/skin_analyze_service.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> postTitles = const [
    'Skin care 101',
    'Trending skincare products',
  ];

  final List<String> bodyContents = const [
    '1. Get the order right.\n'
        '2. Exfoliate once per week.\n'
        '3. Always wear an SPF.\n'
        '4. Drink water, and lots of it.\n'
        '5. Don’t forget your neck and décolletage.',
    "1. Neutrogena® Hydro Boost Water Gel Fragrance Free Moisturizer\n"
        "2. L'Oreal CELL RENEWAL ANTI-AGING MIDNIGHT SERUM\n"
        "3. Neutrogena Rapid Wrinkle Repair® Regenerating Cream"
  ];

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  late SkinAnalyzeService analyzeService;
  Map<String, dynamic>? latestAnalysisResult;
  bool isLoading = false; // Track the loading state

  @override
  void initState() {
    super.initState();
    analyzeService = SkinAnalyzeService();
    _fetchLatestAnalysis();
  }

  Future<void> _fetchLatestAnalysis() async {
    setState(() {
      isLoading = true; // Show loading state
    });

    String? userId = await secureStorage.read(key: 'userID');
    if (userId != null) {
      int userIdInt = int.parse(userId);
      latestAnalysisResult =
          await analyzeService.fetchLatestAnalysisResult(userIdInt);
    }

    setState(() {
      isLoading = false; // Hide loading state
    });
  }

  Future<void> _onRefresh() async {
    await _fetchLatestAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      appBar: const CustomAppBar(),
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(60, 0, 0, 0),
        height: 40,
        onRefresh: _onRefresh, // Trigger refresh on pull
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: postTitles.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    if (isLoading) {
                      return const Center(
                        child: CupertinoActivityIndicator(
                          radius: 14,
                          color: Colors.white,
                        ),
                      );
                    }

                     if (latestAnalysisResult == null) {
                      // No analysis result found, show message to the user with an image
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/home-image.jpg', // Replace with your image path
                                height: 150, // Adjust image size
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'No analysis results available.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Please perform a skin analysis to see your results.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // Map the result to appropriate scores and titles
                    List<double> scores = [
                      latestAnalysisResult!['overall_health_score'] / 100,
                      latestAnalysisResult!['acne_score'] / 100,
                      latestAnalysisResult!['bags_score'] / 100,
                      latestAnalysisResult!['redness_score'] / 100,
                    ];

                    List<String> scoreTitles = [
                      'Overall \nScore',
                      'Acne',
                      'Under-Eye \nBags',
                      'Redness',
                    ];

                    List<Color> progressBarColors = const [
                      Color(0xff92AE1F),
                      Color(0xffDB2B20),
                      Color(0xff12419D),
                      Color(0xffFAFF01),
                    ];

                    return AnalyzeResults(
                      progressBarColors: progressBarColors,
                      scores: scores,
                      titles: scoreTitles,
                    );
                  }

                  if (index == postTitles.length + 1) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 80),
                    );
                  } else {
                    return Post(
                      title: postTitles[index - 1],
                      body: bodyContents[index - 1],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
