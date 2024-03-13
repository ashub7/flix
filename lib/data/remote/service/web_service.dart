import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flix/data/remote/models/cast_response.dart';
import 'package:flix/data/remote/models/movie_detail_response.dart';
import 'package:flix/data/remote/models/movie_photos_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/movie_list_response.dart';

part 'web_service.g.dart';

@RestApi()
@lazySingleton
abstract class WebService {
  factory WebService(Dio dio) = _WebService;

  @factoryMethod
  static WebService create(Dio dio) {
    return WebService(dio);
  }

  @GET("3/trending/movie/week")
  Future<HttpResponse<MovieListResponse>> getLatestMovies(
      @Query("page") int page);

  @GET("3/movie/top_rated")
  Future<HttpResponse<MovieListResponse>> getTopRatedMovies(
      @Query("page") int page);

  @GET("3/movie/{id}")
  Future<HttpResponse<MovieDetailResponse>> getMovieDetail(@Path("id") int id);

  @GET("3/movie/{id}/credits")
  Future<HttpResponse<CastListResponse>> getMovieCast(@Path("id") int id);

  @GET("3/movie/{id}/images")
  Future<HttpResponse<MoviePhotosResponse>> getMoviePhotos(@Path("id") int id);
}
