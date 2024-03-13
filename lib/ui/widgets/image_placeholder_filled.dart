import 'package:flix/core/extension/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ImagePlaceHolderFilled extends StatelessWidget {
  final double radius;
  final String text;
  const ImagePlaceHolderFilled(
      {super.key,
      required this.radius,
      required this.text,
      });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.primaries[math.Random().nextInt(Colors.primaries.length)],
      child: Text(
        text,
        style: context.titleLarge?.copyWith(color: Colors.white),
      ),
    );
  }
}
