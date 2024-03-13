import 'dart:ffi';

import 'package:flix/core/extension/network_extension.dart';
import 'package:flix/data/remote/data_sources/movies_remote_data_source.dart';
import 'package:flix/domain/entities/movie_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flix/domain/repository/movie_repository.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/api_failure.dart';
import '../../domain/entities/cast_entity.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../../domain/entities/movie_photos_entity.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MoviesRemoteDataSource _moviesRemoteDataSource;

  MovieRepositoryImpl(this._moviesRemoteDataSource);

  @override
  Future<Either<ApiFailure, MovieListEntity>> getLatestMovies(int page) async {
    try {
      final response = await _moviesRemoteDataSource.getLatestMovies(page);
      return Right(response.toEntity());
    } on Exception catch (e) {
      return Left(e.mapToFailure());
    }
  }

  @override
  Future<Either<ApiFailure, MovieListEntity>> getTopRatedMovies(int page) async {
    try {
      final response = await _moviesRemoteDataSource.getTopRatedMovies(page);
      return Right(response.toEntity());
    } on Exception catch (e) {
      return Left(e.mapToFailure());
    }
  }

  @override
  Future<Either<ApiFailure, MovieDetailEntity>> getMovieDetail(int movieId) async {
    try {
      final response = await _moviesRemoteDataSource.getMovieDetail(movieId);
      return Right(response.toEntity());
    } on Exception catch (e) {
      return Left(e.mapToFailure());
    }
  }

  @override
  Future<Either<ApiFailure, List<CastEntity>>> getMovieCast(int movieId)  async {
    try {
      final response = await _moviesRemoteDataSource.getMovieCast(movieId);
      return Right(response.cast!.map((e) => e.toEntity()).toList());
    } on Exception catch (e) {
      return Left(e.mapToFailure());
    }
  }

  @override
  Future<Either<ApiFailure, MoviePhotosEntity>> getMoviePhotos(int movieId) async {
    try {
      final response = await _moviesRemoteDataSource.getMoviePhotos(movieId);
      return Right(response.toEntity());
    } on Exception catch (e) {
      return Left(e.mapToFailure());
    }
  }
}
