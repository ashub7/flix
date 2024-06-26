import 'package:equatable/equatable.dart';
import 'package:flix/data/local/database/converters.dart';
import 'package:flix/ui/models/movie_list.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "fav_table")
class FavMovieModel extends Equatable{
  bool adult;
  String? backdropPath;
  @PrimaryKey(autoGenerate: false)
  int id;
  String title;
  String? originalLanguage;
  String? originalTitle;
  String overview;
  String? posterPath;
  String? mediaType;
  double? popularity;
  String? releaseDate;
  bool video;
  double? voteAverage;
  int? voteCount;

  FavMovieModel({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory FavMovieModel.fromUiModel(Movie movie) {
    return FavMovieModel(
        adult: movie.adult,
        backdropPath: movie.backdropPath,
        id: movie.id,
        title: movie.title,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        posterPath: movie.posterPath,
        mediaType: movie.mediaType,
        popularity: movie.popularity,
        releaseDate: movie.releaseDate,
        video: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount);
  }

  Movie toUiModel() {
    return Movie(adult: adult,
        backdropPath: backdropPath,
        id: id,
        title: title,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        posterPath: posterPath,
        mediaType: mediaType,
        genreIds: null,
        popularity: popularity,
        releaseDate: releaseDate,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

  @override
  List<Object?> get props => [id];
}
