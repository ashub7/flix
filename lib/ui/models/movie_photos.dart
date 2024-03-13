import '../../core/utils/constants.dart';

class MoviePhoto {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  MoviePhoto(
      {required this.aspectRatio,
      required this.height,
      required this.iso6391,
      required this.filePath,
      required this.voteAverage,
      required this.voteCount,
      required this.width});

  String movieImage() =>
      filePath != null ? "${Constants.imageBaseUrl}$filePath" : "";

  String posterImage() =>
      filePath != null ? "${Constants.originalImageBaseUrl}$filePath" : "";
}
