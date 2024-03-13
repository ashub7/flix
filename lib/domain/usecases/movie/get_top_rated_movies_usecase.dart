import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flix/core/errors/api_failure.dart';
import 'package:flix/domain/entities/movie_list_entity.dart';
import 'package:flix/domain/repository/movie_repository.dart';
import 'package:flix/domain/usecases/base_usecase_with_param.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTopRatedMoviesUseCase
    extends BaseUseCaseWithParams<MovieListEntity, int> {
  final MovieRepository _movieRepository;

  GetTopRatedMoviesUseCase(this._movieRepository);

  @override
  Future<Either<ApiFailure, MovieListEntity>> call(int params) async {
    return await _movieRepository.getTopRatedMovies(params);
  }
}
