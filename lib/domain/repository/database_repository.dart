import 'dart:ffi';

import 'package:flix/core/errors/api_failure.dart';
import 'package:flix/domain/entities/movie_list_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flix/domain/usecases/account/registration_usecase.dart';

import '../../data/local/model/fav_movie_model.dart';
import '../../data/local/model/user_model.dart';

abstract class DatabaseRepository{
  Future<List<UserModel>> getAllUsers();
  Future<UserModel?> findUserById(int id);
  Future<int> registerUser(RegistrationParams registrationParams);
  Future<void> clearAll();
  Future<int> updateProfile(UserModel userModel);


  Future<List<FavMovieModel>> getAllFavorites();
  Future<FavMovieModel?> findFavoriteById(int id);
  Future<int> addToFavorites(FavMovieModel favMovieModel);
  Future<void> removeFromFavorites(int id);

}