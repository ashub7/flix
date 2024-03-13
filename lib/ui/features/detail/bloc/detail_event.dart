part of 'detail_bloc.dart';

sealed class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailEvent extends DetailEvent {
  final int movieId;
  const LoadDetailEvent({required this.movieId});
}
