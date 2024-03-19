import 'package:cached_network_image/cached_network_image.dart';
import 'package:flix/core/utils/download_service.dart';
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
        actions: [ IconButton(
          onPressed: () {
            DownloadService().enqueueDownload2(imageUrl);
          },
          icon: const Icon(Icons.download),
        )],
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
