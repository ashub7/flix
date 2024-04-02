import 'package:floor/floor.dart';

import '../model/user_model.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM user_table')
  Future<List<UserModel>> findAll();

  @Query('SELECT * FROM user_table WHERE id = :id')
  Future<UserModel?> findPersonById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertUser(UserModel userModel);

  @Query('DELETE FROM user_table')
  Future<void> deleteAll();

  @Query('SELECT * FROM user_table WHERE email = :email')
  Future<UserModel?> findPersonByEmail(String email);
}