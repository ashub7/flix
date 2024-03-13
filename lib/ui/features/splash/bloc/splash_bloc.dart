
import 'package:flix/core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/repository/preference_repository.dart';
import 'splash_event.dart';
import 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final PreferenceRepository _preferenceRepository;

  SplashBloc(this._preferenceRepository) : super(SplashInitial()) {
    on<SplashInitEvent>(_init);
  }

  void _init(SplashInitEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashExit(isLoggedIn: _preferenceRepository.getInt(PreferenceKeys.loggedInUserId)!=-1));
  }
}
