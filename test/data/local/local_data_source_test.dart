import 'package:flix/data/local/database/app_database.dart';
import 'package:flix/data/local/database/fav_dao.dart';
import 'package:flix/data/local/database/user_dao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late UserDao userDao;
  late FavDao favDao;

  setUp(() async {
    database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    userDao = database.userDao;
    favDao = database.favDao;
  });

  tearDown(() async {
    await database.close();
  });
}
