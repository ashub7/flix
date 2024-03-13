import '../../core/utils/constants.dart';

class MovieDetail {
  bool? adult;
  String? backdropPath;
  int? budget;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  int? revenue;
  int? runtime;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  bool isFavorite = false;

  MovieDetail(
      {required this.adult,
      required this.backdropPath,
      required this.budget,
      required this.genres,
      required this.homepage,
      required this.id,
      required this.imdbId,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.revenue,
      required this.runtime,
      required this.status,
      required this.tagline,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount});

  String movieImage() =>
      posterPath != null ? "${Constants.imageBaseUrl}$posterPath" : "";

  String posterImage() =>
      posterPath != null ? "${Constants.originalImageBaseUrl}$posterPath" : "";

  String getAverageRating() {
    if (voteAverage == null) return "0.0";
    return voteAverage!.toStringAsFixed(1);
  }
}

class Genre {
  int? id;
  String? name;

  Genre({required this.id, required this.name});
}
