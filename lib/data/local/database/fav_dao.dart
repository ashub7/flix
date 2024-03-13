import 'package:floor/floor.dart';

import '../model/fav_movie_model.dart';
import '../model/user_model.dart';

@dao
abstract class FavDao {
  @Query('SELECT * FROM fav_table')
  Future<List<FavMovieModel>> findAll();

  @Query('SELECT * FROM fav_table WHERE id = :id')
  Future<FavMovieModel?> findById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> addToFavorites(FavMovieModel favMovieModel);

  @Query('DELETE FROM fav_table WHERE id = :id')
  Future<void> removeFromFavorites(int id);

}