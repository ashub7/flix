part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomePageLoading extends HomeState {}

final class HomeLoadSuccess extends HomeState {
  final MovieList? latest;
  final List<Movie>? topRated;
  final int page;

  const HomeLoadSuccess({this.latest, this.topRated, this.page = 1});
}

final class HomeDataSetChangedState extends HomeState {}

final class NotifyJumpToState extends HomeState {
  final bool show;

  const NotifyJumpToState({required this.show});
}

final class HomeLoadError extends HomeState {
  final String message;
  final int page;

  const HomeLoadError(this.message, this.page);
}

final class MovieListLoadSuccess extends HomeState {
  final MovieList movieList;

  const MovieListLoadSuccess({required this.movieList});
}
