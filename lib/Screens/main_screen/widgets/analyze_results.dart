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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Your latest face analysis results',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          const Divider(
            color: Color.fromARGB(155, 0, 0, 0),
            thickness: 2,
          ),
          // Top Centered Overall Score
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 60,
                  progressColor: widget.progressBarColors[0],
                  percent: widget.scores[0],
                  lineWidth: 10,
                  backgroundColor: Colors.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animationDuration: 900,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(widget.scores[0] * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.titles[0],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Space between rows
          // Row for other 3 circles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 45,
                    progressColor: widget.progressBarColors[index + 1],
                    percent: widget.scores[index + 1],
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
                        '${(widget.scores[index + 1] * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.titles[index + 1],
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
            }),
          ),
        ],
      ),
    );
  }
}
