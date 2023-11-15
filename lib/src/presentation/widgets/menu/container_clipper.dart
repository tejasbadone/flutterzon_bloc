import 'package:flutter/material.dart';

class ContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    final path = Path();

    path.moveTo(0, 100);

    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, 100);
    path.quadraticBezierTo(width * 0.5, 70, 0, 100);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
