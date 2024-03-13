import 'package:flix/domain/entities/movie_list_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_list_response.g.dart';

@JsonSerializable()
class MovieListResponse {
  int page;
  List<MovieResponse> results;
  @JsonKey(name: "total_pages")
  int totalPages;
  @JsonKey(name: "total_results")
  int totalResults;

  MovieListResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);

  MovieListEntity toEntity() {
    return MovieListEntity(
        page: page,
        results: results.map((e) => e.toEntity()).toList(),
        totalPages: totalPages,
        totalResults: totalResults);
  }
}

@JsonSerializable()
class MovieResponse {
  bool adult;
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  int id;
  String title;
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @JsonKey(name: "original_title")
  String? originalTitle;
  String overview;
  @JsonKey(name: "poster_path")
  String? posterPath;
  @JsonKey(name: "media_type")
  String? mediaType;
  @JsonKey(name: "genre_ids")
  List<int>? genreIds;
  double? popularity;
  @JsonKey(name: "release_date")
  String? releaseDate;
  bool video;
  @JsonKey(name: "vote_average")
  double? voteAverage;
  @JsonKey(name: "vote_count")
  int? voteCount;

  MovieResponse({
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
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

  MovieEntity toEntity() => MovieEntity(
      adult: adult,
      backdropPath: backdropPath,
      id: id,
      title: title,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      mediaType: mediaType ?? "",
      genreIds: genreIds,
      popularity: popularity,
      releaseDate: releaseDate,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount);
}
