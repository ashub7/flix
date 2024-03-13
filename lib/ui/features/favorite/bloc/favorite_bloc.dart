import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/local/model/fav_movie_model.dart';
import '../../../../domain/usecases/movie/manage_favorites_usecase.dart';
import '../../../models/movie_list.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

@injectable
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final ManageFavoritesUseCase _manageFavoritesUseCase;

  FavoriteBloc(this._manageFavoritesUseCase) : super(FavoriteInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ChangeFavoriteEvent>(_onChangeFavoriteEvent);
  }

  Future<void> _onLoadFavorites(
      LoadFavorites event, Emitter<FavoriteState> emit) async {
    emit(FavoritesLoading());
    final result = await _manageFavoritesUseCase.getAllFavorites();
    final favList = result.map((e) => e.toUiModel()).toList();
    for (var element in favList) {
      element.isFavorite = true;
    }
    emit(FavoritesLoaded(favList));
  }

  Future<void> _onChangeFavoriteEvent(
      ChangeFavoriteEvent event, Emitter<FavoriteState> emit) async {
    if (event.movie.isFavorite) {
      await _manageFavoritesUseCase.removeFromFavorites(event.movie.id);
      event.movie.isFavorite = false;
      emit(FavoriteModified(event.movie, false));
    } else {
      await _manageFavoritesUseCase
          .addToFavorites(FavMovieModel.fromUiModel(event.movie));
      event.movie.isFavorite = true;
      emit(FavoriteModified(event.movie, true));
    }
  }
}
