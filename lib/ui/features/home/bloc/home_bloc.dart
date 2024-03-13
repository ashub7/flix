import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flix/core/errors/api_failure.dart';
import 'package:flix/data/local/model/fav_movie_model.dart';
import 'package:flix/domain/entities/movie_list_entity.dart';
import 'package:flix/ui/models/movie_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flix/domain/usecases/movie/get_latest_movies_usecase.dart';
import 'package:collection/collection.dart';

import '../../../../domain/usecases/movie/favorite_mapper_usecase.dart';
import '../../../../domain/usecases/movie/get_top_rated_movies_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetLatestMoviesUseCase _getLatestMoviesUseCase;
  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;
  final FavoriteMapperUseCase _favoriteMapperUseCase;

  HomeBloc(this._getLatestMoviesUseCase, this._getTopRatedMoviesUseCase, this._favoriteMapperUseCase)
      : super(HomeInitial()) {
    on<LoadMoviesEvent>(_onLoadMovies);
    on<LoadMoreLatestEvent>(_onLoadMoreLatest);
    on<NotifyHomeListEvent>((event, emit) {
      emit(HomeInitial());
      emit(HomeDataSetChangedState());
    });

  }

  Future<void> _onLoadMoreLatest(
      LoadMoreLatestEvent event, Emitter<HomeState> emit) async {
    emit(HomePageLoading());
    await Future.delayed(const Duration(seconds: 3));
    final result = await _getLatestMoviesUseCase(event.page);
    result.fold(
      (failure) {
        emit(HomeLoadError(failure.message, event.page));
      },
      (response) async {
         _favoriteMapperUseCase.mapList(response);
        emit(HomeLoadSuccess(latest: response.toUiModel(), page: event.page));
      },
    );
  }

  Future<void> _onLoadMovies(
      LoadMoviesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await Future.wait([
      _getLatestMoviesUseCase(1),
      _getTopRatedMoviesUseCase(1),
    ]);
    final errorResponse = result.firstWhereOrNull((element) => element is Left);
    if (errorResponse != null) {
      ApiFailure? failure = errorResponse.fold((l) => l, (r) => null);
      emit(HomeLoadError(failure!.message, 1));
    } else {
      MovieListEntity? latest;
      MovieListEntity? topRated;
      result[0].foldRight(
        null,
        (r, previous) {
          latest = r;
        },
      );
      result[1].foldRight(
        null,
        (r, previous) {
          topRated = r;
        },
      );
      if (latest != null && topRated != null) {
        await _favoriteMapperUseCase.mapList(latest!);
        final topRatedList = topRated!.toUiModel().results;
        topRatedList.shuffle();
        emit(HomeLoadSuccess(
            latest: latest!.toUiModel(), topRated: topRatedList.slice(0, 8)));
      }
    }
  }
}
