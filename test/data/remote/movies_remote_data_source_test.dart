import 'package:dio/dio.dart';
import 'package:flix/data/remote/data_sources/movies_remote_data_source.dart';
import 'package:flix/data/remote/service/web_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WebService webService;
  late MoviesRemoteDataSource moviesRemoteDataSource;
  final movieListResponse = dummyMovieListResponse();
  final castListResponse = dummyCastResponse();
  final photosResponse = dummyPhotosResponse();
  final movieDetailResponse = dummyMovieDetailResponse();

  setUp(() {
    webService = MockWebService();
    moviesRemoteDataSource = MoviesRemoteDataSourceImpl(webService);
  });


  group("getLatestMovies", () {
    test("Should return success", () async {
      when(webService.getLatestMovies(1)).thenAnswer((_) async => HttpResponse(
          movieListResponse,
          Response(statusCode: 200, requestOptions: RequestOptions(path: ""))));
      final result = await moviesRemoteDataSource.getLatestMovies(1);
      expect(result, movieListResponse);
    });

    test("Should return Exception", () async {
      when(webService.getLatestMovies(1))
          .thenAnswer((_) async => throw Exception());
      try {
        await moviesRemoteDataSource.getLatestMovies(1);
      } on Exception catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });



  group("getTopRatedMovies", () {
    test("Should return success", () async {
      when(webService.getTopRatedMovies(1)).thenAnswer((_) async => HttpResponse(
          movieListResponse,
          Response(statusCode: 200, requestOptions: RequestOptions(path: ""))));
      final result = await moviesRemoteDataSource.getTopRatedMovies(1);
      expect(result, movieListResponse);
    });

    test("Should return Exception", () async {
      when(webService.getTopRatedMovies(1))
          .thenAnswer((_) async => throw Exception());
      try {
        await moviesRemoteDataSource.getTopRatedMovies(1);
      } on Exception catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });


  group("getMovieDetail", () {
    test("Should return success", () async {
      when(webService.getMovieDetail(278)).thenAnswer((_) async => HttpResponse(
          movieDetailResponse,
          Response(statusCode: 200, requestOptions: RequestOptions(path: ""))));
      final result = await moviesRemoteDataSource.getMovieDetail(278);
      expect(result, movieDetailResponse);
    });

    test("Should return Exception", () async {
      when(webService.getMovieDetail(278))
          .thenAnswer((_) async => throw Exception());
      try {
        await moviesRemoteDataSource.getMovieDetail(278);
      } on Exception catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });


  group("getMovieCast", () {
    test("Should return success", () async {
      when(webService.getMovieCast(278)).thenAnswer((_) async => HttpResponse(
          castListResponse,
          Response(statusCode: 200, requestOptions: RequestOptions(path: ""))));
      final result = await moviesRemoteDataSource.getMovieCast(278);
      expect(result, castListResponse);
    });

    test("Should return Exception", () async {
      when(webService.getMovieCast(278))
          .thenAnswer((_) async => throw Exception());
      try {
        await moviesRemoteDataSource.getMovieCast(278);
      } on Exception catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });


  group("getMoviePhotos", () {
    test("Should return success", () async {
      when(webService.getMoviePhotos(278)).thenAnswer((_) async => HttpResponse(
          photosResponse,
          Response(statusCode: 200, requestOptions: RequestOptions(path: ""))));
      final result = await moviesRemoteDataSource.getMoviePhotos(278);
      expect(result, photosResponse);
    });

    test("Should return Exception", () async {
      when(webService.getMoviePhotos(278))
          .thenAnswer((_) async => throw Exception());
      try {
        await moviesRemoteDataSource.getMoviePhotos(278);
      } on Exception catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });

}
