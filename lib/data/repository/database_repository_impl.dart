import 'dart:ffi';

import 'package:flix/core/errors/api_failure.dart';
import 'package:flix/data/local/data_sources/local_data_source.dart';
import 'package:flix/data/local/model/fav_movie_model.dart';
import 'package:flix/domain/entities/movie_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data/local/model/user_model.dart';
import '../../domain/repository/database_repository.dart';
import '../../domain/usecases/account/registration_usecase.dart';

@LazySingleton(as: DatabaseRepository)
class DatabaseRepositoryImpl extends DatabaseRepository {
  final LocalDataSource _localUserDataSource;

  DatabaseRepositoryImpl(this._localUserDataSource);

  @override
  Future<void> clearAll() async {
    return _localUserDataSource.clearAll();
  }

  @override
  Future<UserModel?> findUserById(int id) async {
    return _localUserDataSource.findUserById(id);
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    return _localUserDataSource.getAllUsers();
  }

  @override
  Future<int> registerUser(RegistrationParams registrationParams) async {
    return _localUserDataSource
        .registerUser(UserModel.fromParams(registrationParams));
  }

  @override
  Future<int> addToFavorites(FavMovieModel favMovieModel) async {
    return _localUserDataSource.addToFavorites(favMovieModel);
  }

  @override
  Future<FavMovieModel?> findFavoriteById(int id) async {
    return _localUserDataSource.findFavoriteById(id);
  }

  @override
  Future<List<FavMovieModel>> getAllFavorites() async {
    return _localUserDataSource.getAllFavorites();
  }

  @override
  Future<void> removeFromFavorites(int id) async {
    return _localUserDataSource.removeFromFavorites(id);
  }

  @override
  Future<int> updateProfile(UserModel userModel)async{
   return _localUserDataSource.registerUser(userModel);
  }

  @override
  Future<UserModel?> findUserByEmail(String email) async{
    return _localUserDataSource.findUserByEmail(email);
  }
}
