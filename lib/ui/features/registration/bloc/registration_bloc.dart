import 'package:equatable/equatable.dart';
import 'package:flix/core/extension/build_context_ext.dart';
import 'package:flix/core/extension/string_extension.dart';
import 'package:flix/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/usecases/account/registration_usecase.dart';
import '../../../../domain/repository/preference_repository.dart';


part 'registration_event.dart';

part 'registration_state.dart';

@injectable
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationUseCase _registrationUseCase;
  final PreferenceRepository _preferenceRepository;

  RegistrationBloc(this._registrationUseCase, this._preferenceRepository) : super(RegistrationInitial()) {
    on<RegistrationProfilePicEvent>((event, emit) {
      emit(RegistrationProfilePicState(imageUrl: event.imageUrl));
    });
    on<RegistrationSubmitEvent>(_onSubmit);
  }

  Future<void> _onSubmit(RegistrationSubmitEvent event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());
    RegistrationValidationError? errorType =  _validateForm(event);
    if (errorType == null) {
      final userId = await _registrationUseCase(RegistrationParams(
          fullName: event.fullName,
          email: event.email,
          password: event.password,
          gender: event.gender,
          avatar: event.avatar,
          dob: event.dob));
      _preferenceRepository.setInt(PreferenceKeys.loggedInUserId, userId);
      emit(RegistrationSuccess());
    } else {
      emit(RegistrationErrorState(errorType: errorType));
    }
  }

  RegistrationValidationError? _validateForm(
      RegistrationSubmitEvent event)  {
    if (event.fullName.isEmpty) {
      return RegistrationValidationError.nameEmpty;
    } else if (!event.email.isValidEmail()) {
      return RegistrationValidationError.invalidEmail;
    } else if (event.dob.isEmpty) {
      return RegistrationValidationError.dobEmpty;
    } else if (!event.password.isValidPassword()) {
      return RegistrationValidationError.invalidPassword;
    } else if (event.password != event.confirmPassword) {
      return RegistrationValidationError.passwordMatchError;
    }
    return null;
  }
}
