part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

final class LoadFavorites extends FavoriteEvent {
  final bool isRefresh;

  const LoadFavorites({this.isRefresh = false});
}

final class ChangeFavoriteEvent extends FavoriteEvent {
  final Movie movie;

  const ChangeFavoriteEvent(this.movie);
}
