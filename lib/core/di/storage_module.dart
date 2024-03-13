import 'package:flix/data/local/database/app_database.dart';
import 'package:flix/data/local/database/fav_dao.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/database/user_dao.dart';

@module
abstract class StorageModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @preResolve
  @singleton
  Future<AppDatabase> provideDatabase() {
    return $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  @singleton
  UserDao provideUserDao(AppDatabase appDatabase){
    return appDatabase.userDao;
  }
  @singleton
  FavDao provideFavDao(AppDatabase appDatabase){
    return appDatabase.favDao;
  }
}
