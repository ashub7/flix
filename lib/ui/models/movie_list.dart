import 'package:equatable/equatable.dart';
import 'package:flix/core/utils/constants.dart';

class MovieList {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  MovieList({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
}

class Movie extends Equatable{
  final bool adult;
  final String? backdropPath;
  final int id;
  final String title;
  final String? originalLanguage;
  final String? originalTitle;
  final String overview;
  final String? posterPath;
  final String? mediaType;
  final List<int>? genreIds;
  final double? popularity;
  final String? releaseDate;
  final bool video;
  final double? voteAverage;
  final int? voteCount;
  bool isFavorite = false;

  Movie(
      {required this.adult,
      required this.backdropPath,
      required this.id,
      required this.title,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.posterPath,
      required this.mediaType,
      required this.genreIds,
      required this.popularity,
      required this.releaseDate,
      required this.video,
      required this.voteAverage,
      required this.voteCount,
      this.isFavorite = false});

  String movieImage() =>
      posterPath != null ? "${Constants.imageBaseUrl}$posterPath" : "";

  String posterImage() =>
      posterPath != null ? "${Constants.originalImageBaseUrl}$posterPath" : "";

  String getAverageRating() {
    if (voteAverage == null) return "0.0";
    return voteAverage!.toStringAsFixed(1);
  }

  @override
  List<Object?> get props => [id, originalTitle];
}
