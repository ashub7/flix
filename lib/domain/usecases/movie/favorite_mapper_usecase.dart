import 'package:dartz/dartz_unsafe.dart';
import 'package:flix/domain/entities/movie_list_entity.dart';
import 'package:flix/ui/models/movie_detail.dart';
import 'package:injectable/injectable.dart';

import '../../repository/database_repository.dart';

@injectable
class FavoriteMapperUseCase {
  final DatabaseRepository _databaseRepository;

  FavoriteMapperUseCase(this._databaseRepository);

  Future<void> mapList(MovieListEntity movieListEntity) async {
    List<MovieEntity> movieList = movieListEntity.results;
    final favorites = await _databaseRepository.getAllFavorites();
    final idsList = favorites.map((e) => e.id).toList();
    for (var element in movieList) {
      element.isFavorite = idsList.contains(element.id);
    }
  }

  Future<void> mapDetail(MovieDetail movieDetail) async {
    final favorites = await _databaseRepository.getAllFavorites();
    final idsList = favorites.map((e) => e.id).toList();
    movieDetail.isFavorite = idsList.contains(movieDetail.id);
  }
}
