import 'package:cached_network_image/cached_network_image.dart';
import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math' as math;

import '../../../models/movie_list.dart';
import 'movie_image_widget.dart';

class HomeSliderView extends StatefulWidget {
  final List<Movie> movieList;
  final Function(Movie) onItemClicked;

  const HomeSliderView({super.key, required this.movieList, required this.onItemClicked});

  @override
  State<HomeSliderView> createState() => _HomeSliderViewState();
}

class _HomeSliderViewState extends State<HomeSliderView> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: widget.movieList
              .map((movie) => _pageView(movie, context))
              .toList(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SmoothPageIndicator(
              controller: controller,
              count: widget.movieList.length,
              axisDirection: Axis.horizontal,
              effect: WormEffect(
                dotWidth: 20,
                  dotHeight: 7,
                  dotColor: context.onPrimary,
                  activeDotColor: context.primary),
            ),
          ),
        )
      ],
    );
  }

  Widget _pageView(Movie movie, BuildContext context) {
    return SizedBox(
      height: context.screenHeight / 2,
      child: GestureDetector(
        onTap: () => widget.onItemClicked.call(movie),
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              width: double.infinity,
              height: context.screenHeight/2,
              imageUrl: movie.posterImage(),
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                    color: Colors
                        .primaries[math.Random().nextInt(Colors.primaries.length)]
                        .withOpacity(0.5),
                  ),
              ),
              errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
            )
          ],
        ),
      ),
    );
  }
}
