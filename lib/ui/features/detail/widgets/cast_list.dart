import 'package:cached_network_image/cached_network_image.dart';
import 'package:flix/core/extension/text_style_extension.dart';
import 'package:flix/ui/config/app_router.dart';
import 'package:flix/ui/models/cast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/movie_photos.dart';
import 'dart:math' as math;

class CastList extends StatelessWidget {
  final List<Cast> castList;

  const CastList({super.key, required this.castList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => 10.horizontalSpace,
        itemCount: castList.length,
        itemBuilder: (context, index) {
          return _castItem(castList[index]);
        },),
    );
  }

  _castItem(Cast cast) {
    return SizedBox(
      width: 80,
      height: 100,
      child: Column(
        children: [
          CachedNetworkImage(
            width: 80,
            height: 100,
            imageUrl: cast.profileImage,
            errorWidget: (context, url, error) {
              return  const CircleAvatar(
                radius: 30,
                child: Icon(Icons.person),
              );
            },
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                radius: 30,
                backgroundImage: imageProvider,
              );
            },),
          3.verticalSpaceFromWidth,
          Text(cast.name!, style: context.bodyMedium, maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}
