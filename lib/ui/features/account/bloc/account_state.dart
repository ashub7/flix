part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {}

final class AccountLoggedOut extends AccountState {}

final class ProfileLoaded extends AccountState {
  final User user;

  const ProfileLoaded(this.user);
}

final class ProfileUpdated extends AccountState {
  final User user;

  const ProfileUpdated(this.user);
}

final class ProfilePicChangedState extends AccountState {
  final String imageUrl;

  const ProfilePicChangedState({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}
