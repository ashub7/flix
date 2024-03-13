import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/movie_photos.dart';
import 'dart:math' as math;

class PhotosList extends StatelessWidget {
  final List<MoviePhoto> imageList;
  final Function(MoviePhoto) onImageClicked;

  const PhotosList(
      {super.key, required this.imageList, required this.onImageClicked});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => 10.horizontalSpace,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return _photoItem(imageList[index]);
        },),
    );
  }

  _photoItem(MoviePhoto photo) {
    return Material(
      color: Colors.transparent,
      child: Hero(
        tag: photo.movieImage(),
        child: CachedNetworkImage(imageUrl: photo.movieImage(),
          height: 120,
          width: 220,
          placeholder: (context, url) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors
                      .primaries[math.Random().nextInt(Colors.primaries.length)]
                      .withOpacity(0.5),
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(6))),
            );
          },
          imageBuilder: (context, imageProvider) {
            return SizedBox(
              height: 150,
              width: 250,
              child: Card(
                elevation: 0,
                child: Ink(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(6)) ,
                    onTap: () {
                      onImageClicked.call(photo);
                    },
                    //splashColor: Colors.brown.withOpacity(0.5),
                  ),
                ),
              ),
            );
          },),
      ),
    );
  }
}
