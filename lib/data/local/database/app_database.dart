import 'dart:async';
import 'package:flix/data/local/database/fav_dao.dart';
import 'package:flix/data/local/database/user_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../model/fav_movie_model.dart';
import '../model/user_model.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [UserModel, FavMovieModel])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  FavDao get favDao;

}
