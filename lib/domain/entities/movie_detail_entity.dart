import 'package:flix/ui/models/movie_detail.dart';

class MovieDetailEntity {
  bool? adult;
  String? backdropPath;
  int? budget;
  List<GenreEntity>? genres;
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

  MovieDetailEntity(
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

  MovieDetail toUiModel() => MovieDetail(
      adult: adult,
      backdropPath: backdropPath,
      budget: budget,
      genres: genres?.map((e) => e.toUiModel()).toList(),
      homepage: homepage,
      id: id,
      imdbId: imdbId,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      revenue: revenue,
      runtime: runtime,
      status: status,
      tagline: tagline,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount);
}

class GenreEntity {
  int? id;
  String? name;

  GenreEntity({required this.id, required this.name});

  Genre toUiModel() => Genre(id: id, name: name);
}
