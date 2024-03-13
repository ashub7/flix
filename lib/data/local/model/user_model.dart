import 'package:equatable/equatable.dart';
import 'package:flix/domain/usecases/account/registration_usecase.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "user_table")
class UserModel implements Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String fullName;
  final String email;
  final String password;
  final int gender;// 0 male, 1 female
  final String avatar;
  final String dob;

  UserModel(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.password,
      required this.gender,
      required this.avatar,
      required this.dob});

  factory UserModel.fromParams(RegistrationParams params) {
    return UserModel(
        id: null,
        fullName: params.fullName,
        email: params.email,
        password: params.password,
        gender: params.gender,
        avatar: params.avatar,
        dob: params.dob);
  }

  @override
  List<Object?> get props => [id, email];

  @override
  bool? get stringify => true;
}
