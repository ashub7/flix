import 'package:flix/ui/models/movie_photos.dart';

class MoviePhotosEntity {
  List<MovieImageEntity>? backdrops;
  List<MovieImageEntity>? posters;

  MoviePhotosEntity({this.backdrops, this.posters});
}

class MovieImageEntity {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  MovieImageEntity(
      {required this.aspectRatio,
      required this.height,
      required this.iso6391,
      required this.filePath,
      required this.voteAverage,
      required this.voteCount,
      required this.width});

  MoviePhoto toUiModel() => MoviePhoto(
      aspectRatio: aspectRatio,
      height: height,
      iso6391: iso6391,
      filePath: filePath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      width: width);
}
