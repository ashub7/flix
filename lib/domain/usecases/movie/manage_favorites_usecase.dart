import 'package:flix/domain/repository/database_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../data/local/model/fav_movie_model.dart';

@injectable
class ManageFavoritesUseCase {
  final DatabaseRepository _databaseRepository;

  ManageFavoritesUseCase(this._databaseRepository);

  Future<List<FavMovieModel>> getAllFavorites() {
    return _databaseRepository.getAllFavorites();
  }

  Future<FavMovieModel?> findFavoriteById(int id) {
    return _databaseRepository.findFavoriteById(id);
  }

  Future<int> addToFavorites(FavMovieModel favMovieModel) {
    return _databaseRepository.addToFavorites(favMovieModel);
  }

  Future<void> removeFromFavorites(int id) {
    return _databaseRepository.removeFromFavorites(id);
  }
}
