part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

final class RegistrationProfilePicEvent extends RegistrationEvent {
  final String imageUrl;

  const RegistrationProfilePicEvent({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

final class RegistrationSubmitEvent extends RegistrationEvent {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final int gender;
  final String avatar;
  final String dob;

  const RegistrationSubmitEvent(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.gender,
      required this.avatar,
      required this.dob});

  @override
  List<Object> get props =>
      [fullName, email, password, confirmPassword, gender, avatar, dob];
}
