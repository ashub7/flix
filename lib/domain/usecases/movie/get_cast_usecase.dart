import 'package:dartz/dartz.dart';
import 'package:flix/core/errors/api_failure.dart';
import 'package:flix/domain/entities/cast_entity.dart';
import 'package:flix/domain/entities/movie_detail_entity.dart';
import 'package:flix/domain/repository/movie_repository.dart';
import 'package:flix/domain/usecases/base_usecase_with_param.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCastUseCase extends BaseUseCaseWithParams<List<CastEntity>, int> {
  final MovieRepository _movieRepository;


  GetCastUseCase(this._movieRepository);

  @override
  Future<Either<ApiFailure, List<CastEntity>>> call(int params) async {
    return await _movieRepository.getMovieCast(params);
  }
}
