import 'dart:ffi';

import 'package:flix/data/remote/service/web_service.dart';
import 'package:injectable/injectable.dart';

import '../models/cast_response.dart';
import '../models/movie_detail_response.dart';
import '../models/movie_list_response.dart';
import '../models/movie_photos_response.dart';

abstract class MoviesRemoteDataSource {
  Future<MovieListResponse> getLatestMovies(int page);

  Future<MovieListResponse> getTopRatedMovies(int page);

  Future<MovieDetailResponse> getMovieDetail(int movieId);

  Future<CastListResponse> getMovieCast(int movieId);

  Future<MoviePhotosResponse> getMoviePhotos(int movieId);
}

@LazySingleton(as: MoviesRemoteDataSource)
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final WebService _webService;

  MoviesRemoteDataSourceImpl(this._webService);

  @override
  Future<MovieListResponse> getLatestMovies(int page) async {
    final response = await _webService.getLatestMovies(page);
    return response.data;
  }

  @override
  Future<MovieListResponse> getTopRatedMovies(int page) async {
    final response = await _webService.getTopRatedMovies(page);
    return response.data;
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int movieId) async {
    final response = await _webService.getMovieDetail(movieId);
    return response.data;
  }

  @override
  Future<CastListResponse> getMovieCast(int movieId) async {
    final response = await _webService.getMovieCast(movieId);
    return response.data;
  }

  @override
  Future<MoviePhotosResponse> getMoviePhotos(int movieId)async {
    final response = await _webService.getMoviePhotos(movieId);
    return response.data;
  }
}
