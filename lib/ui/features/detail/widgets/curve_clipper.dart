import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width - size.width / 4, size.height, size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.fillType =PathFillType.nonZero;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
