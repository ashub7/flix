part of 'detail_bloc.dart';

sealed class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailState {}

final class DetailLoaded extends DetailState {
  final MovieDetail detail;
  final List<Cast> castList;
  final List<MoviePhoto> backdrops;
  final List<MoviePhoto> posters;

  const DetailLoaded(
      {required this.detail,
      required this.castList,
      required this.backdrops,
      required this.posters});
}

final class DetailLoadError extends DetailState {
  final String message;

  const DetailLoadError(this.message);
}
