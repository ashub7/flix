import 'package:flix/core/extension/color_extension.dart';
import 'package:flix/core/extension/text_style_extension.dart';
import 'package:flix/ui/features/home/widgets/movie_image_widget.dart';
import 'package:flix/ui/models/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieGridTile extends StatelessWidget {
  final Movie movie;
  final Function(Movie) onFavIconClicked;
  final Function(Movie) onItemClicked;

  const MovieGridTile(
      {super.key,
      required this.movie,
      required this.onFavIconClicked,
      required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    return _gridItem(context);
  }

  _gridItem(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(12)),
      onTap: () => onItemClicked(movie),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              MovieImageWidget(
                  height: 180,
                  imageUrl: movie.posterImage(),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed:() => onFavIconClicked(movie),
                    icon: Icon(
                      movie.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_outline,
                      color: movie.isFavorite ? Colors.red : null,
                    )),
              ),
            ],
          ),
          5.verticalSpaceFromWidth,
          Text(
            movie.title,
            style: context.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Expanded(child: _ratingBar(context)),
              Text(
                "(${movie.voteAverage?.toStringAsFixed(1)})",
                style: context.bodySmall?.copyWith(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                movie.releaseDate ?? "",
                style: context.bodySmall?.copyWith(color: Colors.grey),
              )),
              Text(
                "Vote(${movie.voteCount})",
                style: context.bodySmall?.copyWith(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }

  _ratingBar(BuildContext context) {
    return RatingBar.builder(
      initialRating: movie.voteAverage ?? 0.0,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 10,
      itemSize: 14.0,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: context.primary,
      ),
      updateOnDrag: false,
      ignoreGestures: true,
      wrapAlignment: WrapAlignment.spaceBetween,
      onRatingUpdate: (double value) {},
    );
  }
}
