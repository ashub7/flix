import 'package:dartz/dartz.dart';
import 'package:flix/core/errors/api_failure.dart';
import 'package:flix/domain/entities/movie_list_entity.dart';
import 'package:flix/domain/usecases/movie/get_latest_movies_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository movieRepository;
  late GetLatestMoviesUseCase getLatestMoviesUseCase;
  late MovieListEntity movieListEntity;

  setUp(() {
    movieRepository = MockMovieRepository();
    getLatestMoviesUseCase = GetLatestMoviesUseCase(movieRepository);
    movieListEntity = dummyMovieListResponse().toEntity();
  });

  test("GetLatestMoviesUseCase success", () async {
    when(movieRepository.getLatestMovies(1))
        .thenAnswer((_) async => Right(movieListEntity));
    final result = await getLatestMoviesUseCase(1);
    expect(result, Right(movieListEntity));
  });

  test("GetLatestMoviesUseCase error", () async {
    when(movieRepository.getLatestMovies(1))
        .thenAnswer((_) async => Left(ApiFailure("Error")));
    final result = await getLatestMoviesUseCase(1);
    expect(result, isA<Left>());
  });
}
