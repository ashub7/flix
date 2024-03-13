import 'dart:ffi';

import 'package:flix/core/errors/api_failure.dart';
import 'package:flix/domain/entities/cast_entity.dart';
import 'package:flix/domain/entities/movie_detail_entity.dart';
import 'package:flix/domain/entities/movie_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flix/domain/entities/movie_photos_entity.dart';

abstract class MovieRepository{
  Future<Either<ApiFailure, MovieListEntity>> getLatestMovies(int page);
  Future<Either<ApiFailure, MovieListEntity>> getTopRatedMovies(int page);

  Future<Either<ApiFailure, MovieDetailEntity>> getMovieDetail(int movieId);
  Future<Either<ApiFailure, List<CastEntity>>> getMovieCast(int movieId);
  Future<Either<ApiFailure, MoviePhotosEntity>> getMoviePhotos(int movieId);

}