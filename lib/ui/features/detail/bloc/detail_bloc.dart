import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flix/domain/entities/cast_entity.dart';
import 'package:flix/domain/entities/movie_detail_entity.dart';
import 'package:flix/domain/entities/movie_photos_entity.dart';
import 'package:flix/ui/models/cast.dart';
import 'package:flix/ui/models/movie_detail.dart';
import 'package:flix/ui/models/movie_photos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/api_failure.dart';
import '../../../../domain/usecases/movie/get_cast_usecase.dart';
import '../../../../domain/usecases/movie/get_movie_detail_usecase.dart';
import '../../../../domain/usecases/movie/get_movie_photos_usecase.dart';

part 'detail_event.dart';

part 'detail_state.dart';

@injectable
class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetMovieDetailUseCase _getMovieDetailUseCase;
  final GetMoviePhotosUseCase _getMoviePhotosUseCase;
  final GetCastUseCase _getCastUseCase;

  DetailBloc(this._getMovieDetailUseCase, this._getMoviePhotosUseCase,
      this._getCastUseCase)
      : super(DetailInitial()) {
    on<LoadDetailEvent>(_onLoadDetails);
  }

  _onLoadDetails(LoadDetailEvent event, Emitter<DetailState> emit) async {
    emit(DetailLoading());
    final result = await Future.wait([
      _getMovieDetailUseCase(event.movieId),
      _getCastUseCase(event.movieId),
      _getMoviePhotosUseCase(event.movieId),
    ]);
    final errorResponse = result.firstWhereOrNull((element) => element is Left);
    if (errorResponse != null) {
      ApiFailure? failure = errorResponse.fold((l) => l, (r) => null);
      emit(DetailLoadError(failure!.message));
    } else {
      MovieDetail? detail;
      List<Cast>? castList;
      List<MoviePhoto>? backdrops;
      List<MoviePhoto>? posters;
      result[0].foldRight(
        null,
        (r, previous) {
          detail = (r as MovieDetailEntity).toUiModel();
        },
      );
      result[1].foldRight(
        null,
        (r, previous) {
          castList = (r as List<CastEntity>).map((e) => e.toUiModel()).toList();
        },
      );
      result[2].foldRight(
        null,
        (r, previous) {
          backdrops = (r as MoviePhotosEntity)
              .backdrops
              ?.map((e) => e.toUiModel())
              .toList();
          posters = r.posters?.map((e) => e.toUiModel()).toList();
        },
      );
      emit(DetailLoaded(
          detail: detail!,
          castList: castList ?? [],
          backdrops: backdrops ?? [],
          posters: posters ?? []));
    }
  }
}
