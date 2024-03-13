import 'package:equatable/equatable.dart';
import 'package:flix/data/local/model/user_model.dart';

class User {
  final int? id;
  String fullName;
  String email;
  String password;
  int gender; // 0 male, 1 female
  String avatar;
  String dob;

  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.password,
      required this.gender,
      required this.avatar,
      required this.dob});

  factory User.fromDbEntity(UserModel userModel) {
    return User(
        id: userModel.id,
        fullName: userModel.fullName,
        email: userModel.email,
        password: userModel.password,
        gender: userModel.gender,
        avatar: userModel.avatar,
        dob: userModel.dob);
  }

}
