import 'package:flix/data/local/database/user_dao.dart';
import 'package:flix/data/local/model/fav_movie_model.dart';
import 'package:injectable/injectable.dart';
import '../database/fav_dao.dart';
import '../model/user_model.dart';

abstract class LocalDataSource {
  Future<List<UserModel>> getAllUsers();

  Future<UserModel?> findUserById(int id);

  Future<int> registerUser(UserModel userModel);

  Future<void> clearAll();

  Future<List<FavMovieModel>> getAllFavorites();

  Future<FavMovieModel?> findFavoriteById(int id);

  Future<int> addToFavorites(FavMovieModel favMovieModel);

  Future<void> removeFromFavorites(int id);
}

@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  final UserDao _userDao;
  final FavDao _favDao;

  LocalDataSourceImpl(this._userDao, this._favDao);

  @override
  Future<void> clearAll() async {
    return _userDao.deleteAll();
  }

  @override
  Future<UserModel?> findUserById(int id) async {
    return _userDao.findPersonById(id);
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    return _userDao.findAll();
  }

  @override
  Future<int> registerUser(UserModel userModel) async {
    return _userDao.insertUser(userModel);
  }

  @override
  Future<int> addToFavorites(FavMovieModel favMovieModel) async {
    return _favDao.addToFavorites(favMovieModel);
  }

  @override
  Future<FavMovieModel?> findFavoriteById(int id) async {
    return _favDao.findById(id);
  }

  @override
  Future<List<FavMovieModel>> getAllFavorites() async {
    return _favDao.findAll();
  }

  @override
  Future<void> removeFromFavorites(int id) async {
    return _favDao.removeFromFavorites(id);
  }
}
