part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

final class LoadProfile extends AccountEvent {}
final class LogOutEvent extends AccountEvent {}


final class ProfilePicChangeEvent extends AccountEvent {
  final String imageUrl;
  const ProfilePicChangeEvent({required this.imageUrl});
  @override
  List<Object> get props => [imageUrl];
}

final class ProfileUpdateSubmitEvent extends AccountEvent {
  final int id;
  final String fullName;
  final String email;
  final int gender;
  final String avatar;
  final String dob;
  final String password;

  const ProfileUpdateSubmitEvent(
      {required this.id,
        required this.fullName,
        required this.email,
        required this.gender,
        required this.password,
        required this.avatar,
        required this.dob});

  @override
  List<Object> get props =>
      [fullName, email, gender, avatar, dob];
}
