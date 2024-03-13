import 'package:cached_network_image/cached_network_image.dart';
import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/color_extension.dart';
import 'package:flix/core/extension/text_style_extension.dart';
import 'package:flix/ui/config/app_router.dart';
import 'package:flix/ui/config/rout_names.dart';
import 'package:flix/ui/features/detail/bloc/detail_bloc.dart';
import 'package:flix/ui/features/detail/widgets/cast_list.dart';
import 'package:flix/ui/features/detail/widgets/curve_clipper.dart';
import 'package:flix/ui/features/detail/widgets/photos_list.dart';
import 'package:flix/ui/features/home/widgets/movie_image_widget.dart';
import 'package:flix/ui/models/movie_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:sprintf/sprintf.dart';

import '../../../core/di/injector.dart';
import '../../widgets/api_error_widget.dart';

class DetailScreen extends StatefulWidget {
  final int movieId;

  const DetailScreen({super.key, required this.movieId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailBloc _detailBloc;

  @override
  void initState() {
    super.initState();
    _detailBloc = getIt<DetailBloc>();
    _detailBloc.add(LoadDetailEvent(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder(
        bloc: _detailBloc,
        builder: (BuildContext context, state) {
          if (state is DetailLoadError) {
            return ApiErrorWidget(
              errorText: state.message,
              onRetry: () {
                _detailBloc
                    .add(LoadDetailEvent(movieId: widget.movieId));
              },
            );
          } else if (state is DetailLoaded) {
            return _detailBody(state);
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }

  _detailBody(DetailLoaded state) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          _posterImage(state.detail.posterImage()),
          Padding(
            padding: EdgeInsets.only(
                top: context.screenHeight * .30,
                left: 10,
                right: 10,
                bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _movieContentRow(state.detail),
                15.verticalSpaceFromWidth,
                Text(
                  context.loc.story_line,
                  style: context.titleLarge,
                ),
                ReadMoreText(
                  state.detail.overview!,
                  style: context.bodySmall?.copyWith(height: 1.4),
                  trimMode: TrimMode.Line,
                  trimCollapsedText: '  Show more',
                  trimExpandedText: '  show less',
                ),
                15.verticalSpaceFromWidth,
                Text(
                  context.loc.photos,
                  style: context.titleLarge,
                ),
                10.verticalSpaceFromWidth,
                PhotosList(
                  imageList: state.backdrops,
                  onImageClicked: (photo) {
                    context.push(RoutesName.fullScreenImage.path,
                        extra: {"imageUrl": photo.movieImage()});
                  },
                ),
                15.verticalSpaceFromWidth,
                Text(
                  context.loc.cast,
                  style: context.titleLarge,
                ),
                10.verticalSpaceFromWidth,
                CastList(castList: state.castList)
              ],
            ),
          )
        ],
      ),
    );
  }

  _movieContentRow(MovieDetail movieDetail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Adjust the radius as needed
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 5.0,
          child: CachedNetworkImage(
            width: 100,
            height: 150,
            imageUrl: movieDetail.movieImage(),
          ),
        ),
        10.horizontalSpace,
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movieDetail.originalTitle!,
              style: context.titleMedium,
              maxLines: 1,
            ),
            3.verticalSpaceFromWidth,
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieDetail.getAverageRating(),
                      style: context.titleMedium,
                    ),
                    Text(
                      context.loc.ratings,
                      style: context.bodySmall?.copyWith(color: Colors.grey),
                    )
                  ],
                ),
                12.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ratingBar(movieDetail),
                    Text(
                      context.loc.grade_now,
                      style: context.bodySmall?.copyWith(color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
            5.verticalSpaceFromWidth,
            Text(
              sprintf(context.loc.f_popularity, [movieDetail.popularity]),
              style: context.bodyMedium,
            ),
            5.verticalSpaceFromWidth,
            Text(
              sprintf(context.loc.f_revenue, [movieDetail.revenue]),
              style: context.bodyMedium,
            )
          ],
        ))
      ],
    );
  }

  _ratingBar(MovieDetail movieDetail) {
    return RatingBar.builder(
      initialRating: movieDetail.voteAverage ?? 0.0,
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

  _posterImage(String imageUrl) {
    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        foregroundDecoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.black45,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          width: double.infinity,
          height: context.screenHeight * .35,
          imageUrl: imageUrl,
          placeholder: (context, url) => Container(
            decoration: BoxDecoration(
              color: Colors
                  .primaries[math.Random().nextInt(Colors.primaries.length)]
                  .withOpacity(0.5),
            ),
          ),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ),
      ),
    );
  }
}
