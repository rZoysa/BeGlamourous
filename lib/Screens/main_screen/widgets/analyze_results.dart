import 'package:flutter/material.dart';

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
    return Flexible(
      child: Container(
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
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: CustomPaint(
                        painter: CirclePainter(
                          widget.scores[index],
                          widget.progressBarColors[index],
                        ),
                      ),
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
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress;
  final Color color;
  CirclePainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 7.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;
    double angle = 2 * 3.141592653589793 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
