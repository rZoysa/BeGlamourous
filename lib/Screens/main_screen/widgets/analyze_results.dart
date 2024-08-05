import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnalyzeResults extends StatefulWidget {
  final List<double> scores;
  final List<String> titles;
  final List<Color> progressBarColors;

  const AnalyzeResults({
    super.key,
    required this.scores,
    required this.titles,
    required this.progressBarColors,
  });

  @override
  State<AnalyzeResults> createState() => _AnalyzeResultsState();
}

class _AnalyzeResultsState extends State<AnalyzeResults> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(10, 255, 255, 255),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Your latest face analyze results',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          const Divider(
            color: Color.fromARGB(155, 0, 0, 0),
            thickness: 2,
          ),
          GridView.builder(
            itemCount: widget.titles.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.1,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 45,
                    progressColor: widget.progressBarColors[index],
                    percent: widget.scores[index],
                    lineWidth: 7,
                    backgroundColor: Colors.transparent,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animationDuration: 900,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${(widget.scores[index] * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.titles[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
