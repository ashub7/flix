import 'package:flix/ui/models/movie_list.dart';

final class EventFavoriteChange {
  final Movie movie;
  final bool isAdded;
  final String from;

  EventFavoriteChange(
      {required this.movie, required this.isAdded, required this.from});
}
