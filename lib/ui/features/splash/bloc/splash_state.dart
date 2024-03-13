import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable{
  @override
  List<Object?> get props => [];
}
final class SplashInitial extends SplashState{

}
final class SplashExit extends SplashState{
  final bool isLoggedIn;

  SplashExit({required this.isLoggedIn});

}
