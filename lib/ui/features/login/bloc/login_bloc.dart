import 'package:equatable/equatable.dart';
import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/string_extension.dart';
import 'package:flix/domain/usecases/account/login_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flix/domain/repository/preference_repository.dart';

import '../../../../core/utils/constants.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PreferenceRepository _preferenceRepository;
  final LoginUseCase _loginUseCase;
   LoginBloc(this._preferenceRepository, this._loginUseCase) : super(LoginInitial()) {
    on<LoginSubmitEvent>(_onLoginUserEvent);
  }

  Future<void> _onLoginUserEvent(
      LoginSubmitEvent event, Emitter<LoginState> emit) async {
    //emit.call(LoginLoading());
    if(!event.email.isValidEmail()){
      emit(const LoginError(errorType: LoginValidationError.invalidEmail));
    }else if(!event.password.isValidPassword()){
      emit(const LoginError(errorType: LoginValidationError.invalidPassword));
    }else{
      await Future.delayed(const Duration(seconds: 2));
      final loginUserId = await _loginUseCase(LoginParams(email: event.email, password: event.password));
      if(loginUserId!=-1) {
        _preferenceRepository.setInt(PreferenceKeys.loggedInUserId, loginUserId);
        emit(LoginSuccess());
      }else{
        emit(const LoginError(errorType: LoginValidationError.invalidCredentials));
      }
    }
  }
}
