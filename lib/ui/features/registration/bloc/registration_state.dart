part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

final class RegistrationInitial extends RegistrationState {}

final class RegistrationLoading extends RegistrationState {}

final class RegistrationSuccess extends RegistrationState {}


final class RegistrationProfilePicState extends RegistrationState {
  final String imageUrl;
  const RegistrationProfilePicState({required this.imageUrl});
  @override
  List<Object> get props => [imageUrl];
}

final class RegistrationErrorState extends RegistrationState {
  final RegistrationValidationError errorType;

  const RegistrationErrorState({required this.errorType});
}

enum RegistrationValidationError {
  invalidPassword,
  invalidEmail,
  nameEmpty,
  dobEmpty,
  passwordMatchError,
  userAlreadyExists
}

extension RegistrationErrorMapper on RegistrationValidationError {
  errorString(BuildContext context) {
    switch (this) {
      case RegistrationValidationError.invalidEmail:
        return context.loc.invalid_email;
      case RegistrationValidationError.invalidPassword:
        return context.loc.invalid_password;
      case RegistrationValidationError.nameEmpty:
        return context.loc.invalid_name;
      case RegistrationValidationError.dobEmpty:
        return context.loc.invalid_dob;
      case RegistrationValidationError.passwordMatchError:
        return context.loc.password_not_matched;
      case RegistrationValidationError.userAlreadyExists:
        return context.loc.user_exists;
    }
  }
}
