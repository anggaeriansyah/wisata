import 'package:flutter/material.dart';

class MyShapeBorder extends ContinuousRectangleBorder {
  const MyShapeBorder();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double radius = 20.0; // Radius sudut yang diinginkan

    Path path = Path();
    path.lineTo(rect.width, 0);
    path.lineTo(rect.width, rect.height - radius);
    path.quadraticBezierTo(
        rect.width, rect.height, rect.width - radius, rect.height);
    path.lineTo(radius, rect.height);
    path.quadraticBezierTo(0, rect.height, 0, rect.height - radius);
    path.lineTo(0, 0);

    return path;
  }
}
