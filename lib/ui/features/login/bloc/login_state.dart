part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final LoginValidationError errorType;

  const LoginError({required this.errorType});
}

enum LoginValidationError { invalidPassword, invalidEmail, invalidCredentials }

extension LoginErrorMapper on LoginValidationError {
  errorString(BuildContext context) {
    if (this == LoginValidationError.invalidEmail) {
      return context.loc.invalid_email;
    } else if (this == LoginValidationError.invalidPassword) {
      return context.loc.invalid_password;
    }else if (this == LoginValidationError.invalidCredentials) {
      return context.loc.invalid_credentials;
    }
  }
}
