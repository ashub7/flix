import 'package:dartz/dartz.dart';
import 'package:flix/core/errors/api_failure.dart';
import 'package:flix/domain/entities/cast_entity.dart';
import 'package:flix/domain/usecases/movie/get_cast_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository movieRepository;
  late GetCastUseCase getCastUseCase;
  late List<CastEntity> castListResponse;

  setUp(() {
    movieRepository = MockMovieRepository();
    getCastUseCase = GetCastUseCase(movieRepository);
    castListResponse =
        dummyCastResponse().cast!.map((e) => e.toEntity()).toList();
  });

  test("GetCastUseCase success", () async {
    when(movieRepository.getMovieCast(278))
        .thenAnswer((_) async => Right(castListResponse));
    final result = await getCastUseCase(278);
    expect(result, Right(castListResponse));
  });

  test("GetCastUseCase error", () async {
    when(movieRepository.getMovieCast(278))
        .thenAnswer((_) async => Left(ApiFailure("Error")));
    final result = await getCastUseCase(278);
    expect(result, isA<Left>());
  });
}
