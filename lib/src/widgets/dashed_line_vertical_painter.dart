import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashedLineVerticalPainter extends CustomPainter {

  final Color lineColors;
  final double dashHeight;
  final double dashSpace;

  DashedLineVerticalPainter({this.lineColors = Colors.black, this.dashHeight = 5, this.dashSpace  = 3});

  @override
  void paint(Canvas canvas, Size size) {
    double startY = 0;
    final paint = Paint()
      ..color = lineColors
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}