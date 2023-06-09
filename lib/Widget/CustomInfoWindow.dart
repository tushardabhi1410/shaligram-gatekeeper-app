import 'package:flutter/material.dart';

class CustomInfoWindowDesign extends CustomClipper<Path>{
  final double borderRadius = 10;
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double rheight = height - height / 6;
    double oneThird = width / 2.2;

    final path = Path()
      ..lineTo(0, rheight - borderRadius)
      ..cubicTo(0, rheight - borderRadius, 0, rheight, borderRadius, rheight)
      ..lineTo(oneThird, rheight)
      ..lineTo(width / 2 , height)
      // ..cubicTo(width / 2 - borderRadius, height - borderRadius, width / 2,
      //     height, width / 2 + borderRadius, height - borderRadius )
      ..lineTo(width - oneThird, rheight)
      ..lineTo(width-borderRadius, rheight)
      ..cubicTo(width - borderRadius, rheight, width, rheight, width,
          rheight - borderRadius)
      ..lineTo(width, 0)
      ..lineTo(0, 0);

    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}