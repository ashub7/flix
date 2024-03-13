part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class LoadMoviesEvent extends HomeEvent {
}

final class NotifyHomeListEvent extends HomeEvent {
}


final class LoadMoreLatestEvent extends HomeEvent {
  final int page;
  const LoadMoreLatestEvent(this.page);
}




