part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoritesLoading extends FavoriteState {}

final class FavoritesLoaded extends FavoriteState {
  final List<Movie> movies;

  const FavoritesLoaded(this.movies);
}

final class FavoriteModified extends FavoriteState {
  final Movie movie;
  final bool isAdded;

  const FavoriteModified(this.movie, this.isAdded);

  @override
  List<Object> get props => [movie.id, isAdded];
}
