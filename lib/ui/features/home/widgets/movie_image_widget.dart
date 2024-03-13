import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;

class MovieImageWidget extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;
  final double height;
  final double width;

  const MovieImageWidget(
      {super.key,
      required this.imageUrl,
      this.borderRadius,
      required this.height,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        foregroundDecoration: BoxDecoration(
          borderRadius: borderRadius,
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.black.withOpacity(0),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          shape: BoxShape.rectangle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => _imagePlaceholder(),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    );
  }

  _imagePlaceholder() {
    return Container(
      decoration: BoxDecoration(
          color: Colors
              .primaries[math.Random().nextInt(Colors.primaries.length)]
              .withOpacity(0.5),
          borderRadius: const BorderRadius.only(topRight: Radius.circular(12))),
    );
  }
}
