part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginSubmitEvent extends LoginEvent{
  final String email;
  final String password;
  const LoginSubmitEvent({required this.email, required this.password});

  @override
  List<Object> get props =>[email, password];
}
