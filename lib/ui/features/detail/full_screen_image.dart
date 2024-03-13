import 'package:cached_network_image/cached_network_image.dart';
import 'package:flix/ui/config/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_zoom/widget_zoom.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Dismissible(
        key: ValueKey<String>(imageUrl),
        direction: DismissDirection.vertical,
        onDismissed: (direction) {
          context.pop();
        },
        child: Center(
          child: WidgetZoom(
            heroAnimationTag: imageUrl,
            zoomWidget: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
