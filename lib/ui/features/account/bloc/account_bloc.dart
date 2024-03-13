import 'package:equatable/equatable.dart';
import 'package:flix/data/local/model/user_model.dart';
import 'package:flix/ui/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/constants.dart';
import '../../../../domain/repository/preference_repository.dart';
import '../../../../domain/usecases/account/profile_usecase.dart';

part 'account_event.dart';

part 'account_state.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final ProfileUseCase _profileUseCase;
  final PreferenceRepository _preferenceRepository;

  AccountBloc(this._profileUseCase, this._preferenceRepository)
      : super(AccountInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<ProfileUpdateSubmitEvent>(_onUpdateProfile);
    on<ProfilePicChangeEvent>((event, emit) {
      emit(ProfilePicChangedState(imageUrl: event.imageUrl));
    });
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<AccountState> emit) async {
    final result = await _profileUseCase.getProfileById(
        _preferenceRepository.getInt(PreferenceKeys.loggedInUserId));
    emit(ProfileLoaded(User.fromDbEntity(result!)));
  }

  Future<void> _onUpdateProfile(
      ProfileUpdateSubmitEvent event, Emitter<AccountState> emit) async {
    final user = UserModel(
        id: event.id,
        fullName: event.fullName,
        email: event.email,
        password: event.password,
        gender: event.gender,
        avatar: event.avatar,
        dob: event.dob);
    await _profileUseCase.updateProfile(user);
    emit(ProfileUpdated(User.fromDbEntity(user)));
  }
}
