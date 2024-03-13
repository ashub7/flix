import 'package:flix/ui/models/movie_list.dart';
import 'package:json_annotation/json_annotation.dart';

class MovieListEntity {
  int page;
  List<MovieEntity> results;
  int totalPages;
  int totalResults;

  MovieListEntity({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  MovieList toUiModel() => MovieList(
      page: page,
      results: results.map((e) => e.toUiModel()).toList(),
      totalPages: totalPages,
      totalResults: totalResults);
}

class MovieEntity {
  bool adult;
  String? backdropPath;
  int id;
  String title;
  String? originalLanguage;
  String? originalTitle;
  String overview;
  String? posterPath;
  String? mediaType;
  List<int>? genreIds;
  double? popularity;
  String? releaseDate;
  bool video;
  double? voteAverage;
  int? voteCount;
  bool isFavorite;

  MovieEntity({
    required this.adult,
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
    this.isFavorite = false
  });


  Movie toUiModel() => Movie(
      adult: adult,
      backdropPath: backdropPath,
      id: id,
      title: title,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      mediaType: mediaType,
      genreIds: genreIds,
      popularity: popularity,
      releaseDate: releaseDate,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
      isFavorite : isFavorite);
}
