import 'package:dartz/dartz.dart';
import 'package:flix/core/errors/api_failure.dart';

abstract class BaseUseCaseWithParams<R,P>{
  Future<Either<ApiFailure, R>> call(P params);
}

abstract class BaseLocalUseCaseWithParams<R,P>{
  Future<R> call(P params);
}