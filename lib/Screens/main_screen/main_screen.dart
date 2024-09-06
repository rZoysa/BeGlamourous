import 'package:be_glamourous/Screens/main_screen/widgets/analyze_results.dart';
import 'package:be_glamourous/Screens/main_screen/widgets/post.dart';
import 'package:be_glamourous/components/cutom_app_bar.dart';
import 'package:flutter/material.dart';

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

  final List<double> scores = const [
    0.74,
    0.83,
    0.91,
    0.61,
  ];

  final List<String> scoreTitles = const [
    'Overall \nScore',
    'Acne',
    'Under-Eye \nBags',
    'Redness',
  ];

  final List<Color> progressBarColors = const [
    Color(0xff92AE1F),
    Color(0xffDB2B20),
    Color(0xff12419D),
    Color(0xffFAFF01),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: postTitles.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
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
    );
  }
}
