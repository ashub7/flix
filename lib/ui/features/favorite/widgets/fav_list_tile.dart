import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/color_extension.dart';
import 'package:flix/core/extension/text_style_extension.dart';
import 'package:flix/ui/config/app_router.dart';
import 'package:flix/ui/features/home/widgets/movie_image_widget.dart';
import 'package:flix/ui/models/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprintf/sprintf.dart';

class FavoriteListTile extends StatelessWidget {
  final Movie movie;
  final Function(Movie) onFavIconClicked;
  final Function(Movie) onItemClicked;

  const FavoriteListTile(
      {super.key,
      required this.movie,
      required this.onFavIconClicked,
      required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return _gridItem(context);
  }

  _gridItem(BuildContext context) {
    return SizedBox(
      height: 200,
      child: InkWell(
        onTap: () => onItemClicked(movie),
        child: Stack(
          children: [
            Stack(alignment: Alignment.center, children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: CachedNetworkImage(
                  imageUrl: movie.posterImage(),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
              _content()
            ])
          ],
        ),
      ),
    );
  }

  _content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: MovieImageWidget(
                height: 170,
                width: 100,
                imageUrl: movie.posterImage(),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
          ),
          8.horizontalSpace,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    movie.originalTitle!,
                    style: context.headlineSmall?.copyWith(
                      shadows: const <Shadow>[
                        Shadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  )),
                  IconButton(
                      onPressed: () => onFavIconClicked(movie),
                      icon: Icon(
                        size: 35,
                        Icons.favorite_rounded,
                        color: movie.isFavorite ? Colors.red : null,
                      )),
                ],
              ),
              8.verticalSpaceFromWidth,
              Text(
                sprintf(context.loc.f_rating, [movie.getAverageRating()]),
                style: context.titleMedium?.copyWith(
                  shadows: const <Shadow>[
                    Shadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
